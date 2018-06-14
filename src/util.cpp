#include <Windows.h>
#include <boost/algorithm/string.hpp>
#include <boost/filesystem.hpp>
#include <boost/regex.hpp>
#include <cor.h>
#include <iostream>
#include <winnt.h>

// https://www.codeguru.com/cpp/w-p/dll/openfaq/article.php/c14001/Determining-Whether-a-DLL-or-EXE-Is-a-Managed-Component.htm#page-1
DWORD GetActualAddressFromRVA(IMAGE_SECTION_HEADER *pSectionHeader,
							  IMAGE_NT_HEADERS *pNTHeaders, DWORD dwRVA)
{
	DWORD dwRet = 0;

	for (int j = 0; j < pNTHeaders->FileHeader.NumberOfSections;
		 j++, pSectionHeader++)
	{
		DWORD cbMaxOnDisk =
			min(pSectionHeader->Misc.VirtualSize, pSectionHeader->SizeOfRawData);

		DWORD startSectRVA, endSectRVA;

		startSectRVA = pSectionHeader->VirtualAddress;
		endSectRVA = startSectRVA + cbMaxOnDisk;

		if ((dwRVA >= startSectRVA) && (dwRVA < endSectRVA))
		{
			dwRet = (pSectionHeader->PointerToRawData) + (dwRVA - startSectRVA);
			break;
		}
	}

	return dwRet;
}

// https://www.codeguru.com/cpp/w-p/dll/openfaq/article.php/c14001/Determining-Whether-a-DLL-or-EXE-Is-a-Managed-Component.htm#page-1
BOOL IsManaged(boost::filesystem::path lpszImageName)
{
	BOOL bIsManaged = FALSE; // variable that indicates whether
	// managed or not.
	wchar_t szPath[MAX_PATH]; // for convenience

	HANDLE hFile = CreateFileW(lpszImageName.wstring().c_str(), GENERIC_READ,
							   FILE_SHARE_READ, NULL, OPEN_EXISTING,
							   FILE_ATTRIBUTE_NORMAL, NULL);

	// attempt the standard paths (Windows dir and system dir) if
	// CreateFile failed in the first place.
	if (INVALID_HANDLE_VALUE == hFile)
	{
		// try to locate in Windows directory
		GetWindowsDirectoryW(szPath, MAX_PATH);
		wcscat(szPath, L"\\");
		wcscat(szPath, lpszImageName.wstring().c_str());
		hFile = CreateFile(szPath, GENERIC_READ, FILE_SHARE_READ, NULL,
						   OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
	}

	if (INVALID_HANDLE_VALUE == hFile)
	{
		// try to locate in system directory
		GetSystemDirectoryW(szPath, MAX_PATH);
		wcscat(szPath, L"\\");
		wcscat(szPath, lpszImageName.wstring().c_str());
		hFile = CreateFile(szPath, GENERIC_READ, FILE_SHARE_READ, NULL,
						   OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
	}

	if (INVALID_HANDLE_VALUE != hFile)
	{
		// succeeded
		HANDLE hOpenFileMapping =
			CreateFileMapping(hFile, NULL, PAGE_READONLY, 0, 0, NULL);
		if (hOpenFileMapping)
		{
			BYTE *lpBaseAddress = NULL;

			// Map the file, so it can be simply be acted on as a
			// contiguous array of bytes
			lpBaseAddress =
				(BYTE *)MapViewOfFile(hOpenFileMapping, FILE_MAP_READ, 0, 0, 0);

			if (lpBaseAddress)
			{
				// having mapped the executable, now start navigating
				// through the sections

				// DOS header is straightforward. It is the topmost
				// structure in the PE file
				// i.e. the one at the lowest offset into the file
				IMAGE_DOS_HEADER *pDOSHeader = (IMAGE_DOS_HEADER *)lpBaseAddress;

				// the only important data in the DOS header is the
				// e_lfanew
				// the e_lfanew points to the offset of the beginning
				// of NT Headers data
				IMAGE_NT_HEADERS *pNTHeaders =
					(IMAGE_NT_HEADERS *)((BYTE *)pDOSHeader + pDOSHeader->e_lfanew);

				// store the section header for future use. This will
				// later be need to check to see if metadata lies within
				// the area as indicated by the section headers
				IMAGE_SECTION_HEADER *pSectionHeader =
					(IMAGE_SECTION_HEADER *)((BYTE *)pNTHeaders +
											 sizeof(IMAGE_NT_HEADERS));

				// Now, start parsing
				// First of all check if it is a PE file. All assemblies
				// are PE files.
				if (pNTHeaders->Signature == IMAGE_NT_SIGNATURE)
				{
					// start parsing COM table (this is what points to
					// the metadata and other information)
					DWORD dwNETHeaderTableLocation =
						pNTHeaders->OptionalHeader
							.DataDirectory[IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR]
							.VirtualAddress;

					if (dwNETHeaderTableLocation)
					{
						//.NET header data does exist for this module;
						// find its location in one of the sections
						IMAGE_COR20_HEADER *pNETHeader =
							(IMAGE_COR20_HEADER *)((BYTE *)pDOSHeader +
												   GetActualAddressFromRVA(
													   pSectionHeader, pNTHeaders,
													   dwNETHeaderTableLocation));

						if (pNETHeader)
						{
							// valid address obtained. Suffice it to say,
							// this is good enough to identify this as a
							// valid managed component
							bIsManaged = TRUE;
						}
					}
				}
				else
				{
					std::cout << "Not PE file\r\n";
				}
				// cleanup
				UnmapViewOfFile(lpBaseAddress);
			}
			// cleanup
			CloseHandle(hOpenFileMapping);
		}
		// cleanup
		CloseHandle(hFile);
	}
	return bIsManaged;
}

void find_files(std::list<boost::filesystem::path> &paths,
				boost::filesystem::path dest_dir,
				boost::filesystem::path name)
{
	std::wstring n = name.wstring();
	boost::to_lower(n);

	std::list<boost::filesystem::path> all_matching_files;
	if (boost::filesystem::exists(dest_dir))
	{
		boost::filesystem::recursive_directory_iterator dir(dest_dir);
		for (auto &&i : dir)
		{
			std::string extension = i.path().extension().string();
			if (!boost::filesystem::is_regular_file(i.status()))
				continue;

			boost::smatch what;
			std::wstring l = i.path().leaf().wstring();
			boost::to_lower(l);
			if (l == n)
				paths.push_back(i.path());
		}
	}
}

// https://www.codeproject.com/tips/333559/WebControls/
BOOL executeCommandLine(std::wstring cmdLine, DWORD &exitCode)
{
	PROCESS_INFORMATION processInformation = {0};
	STARTUPINFOW startupInfo = {0};
	startupInfo.cb = sizeof(startupInfo);

	cmdLine.resize(cmdLine.size() + 50);

	// Create the process
	BOOL result = CreateProcessW(NULL, (LPWSTR)cmdLine.data(), NULL, NULL, FALSE,
								 NORMAL_PRIORITY_CLASS | CREATE_NO_WINDOW, NULL,
								 NULL, &startupInfo, &processInformation);

	if (!result)
	{
		// CreateProcess() failed
		// Get the error from the system
		LPVOID lpMsgBuf;
		DWORD dw = GetLastError();
		FormatMessageW(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM |
						   FORMAT_MESSAGE_IGNORE_INSERTS,
					   NULL, dw, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
					   (LPWSTR)&lpMsgBuf, 0, NULL);

		// TRACE(_T("::executeCommandLine() failed at
		// CreateProcess()\nCommand=%s\nMessage=%s\n\n"), cmdLine, strError);
		std::wcerr << (wchar_t *)lpMsgBuf << std::endl;
		// Free resources created by the system
		LocalFree(lpMsgBuf);

		// We failed.
		return FALSE;
	}
	else
	{
		// Successfully created the process.  Wait for it to finish.
		WaitForSingleObject(processInformation.hProcess, INFINITE);

		// Get the exit code.
		result = GetExitCodeProcess(processInformation.hProcess, &exitCode);

		// Close the handles.
		CloseHandle(processInformation.hProcess);
		CloseHandle(processInformation.hThread);

		if (!result)
		{
			// Could not get exit code.
			// TRACE(_T("Executed command but couldn't get exit code.\nCommand=%s\n"),
			// cmdLine);
			return FALSE;
		}

		// We succeeded.
		return TRUE;
	}
}

//https://stackoverflow.com/questions/3790613/how-to-convert-a-string-of-hex-values-to-a-string
unsigned char hexval(unsigned char c)
{
	if ('0' <= c && c <= '9')
		return c - '0';
	else if ('a' <= c && c <= 'f')
		return c - 'a' + 10;
	else if ('A' <= c && c <= 'F')
		return c - 'A' + 10;
	else
		abort();
}

void hex2ascii(const std::string &in, std::string &out)
{
	out.clear();
	out.reserve(in.length() / 2);
	for (std::string::const_iterator p = in.begin(); p != in.end(); p++)
	{
		unsigned char c = hexval(*p);
		p++;
		if (p == in.end())
			break;				   // incomplete last digit - should report error
		c = (c << 4) + hexval(*p); // + takes precedence over <<
		out.push_back(c);
	}
}

void removestr(std::string &str, const std::string &begin_tok, const std::string &end_tok)
{
	auto bi = boost::algorithm::find_first(str, begin_tok);
	if (bi)
	{
		auto ei = boost::algorithm::find_first(str, end_tok);
		if (bi && ei)
		{
			std::string b(str.begin(), bi.begin());
			std::string e(ei.end(), str.end());
			str = b + e;
		}
		else
		{
			std::cout << "error" << std::endl;
		}
	}
	else
	{
		std::cout << "error" << std::endl;
	}
}

//https://stackoverflow.com/questions/2933295/embed-text-file-in-a-resource-in-a-native-windows-application
void LoadFileInResource(int name, int type, std::string &data)
{
	HMODULE handle = ::GetModuleHandle(NULL);
	HRSRC rc =
		::FindResource(handle, MAKEINTRESOURCE(name), MAKEINTRESOURCE(type));
	HGLOBAL rcData = ::LoadResource(handle, rc);
	DWORD size = ::SizeofResource(handle, rc);
	const char *ptr = static_cast<const char *>(::LockResource(rcData));
	data.assign(ptr, ptr + size);
}
