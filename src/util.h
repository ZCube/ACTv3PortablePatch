#pragma once
#include <Windows.h>
#include <boost/filesystem.hpp>
#include <cor.h>
#include <iostream>
#include <winnt.h>

// https://www.codeguru.com/cpp/w-p/dll/openfaq/article.php/c14001/Determining-Whether-a-DLL-or-EXE-Is-a-Managed-Component.htm#page-1
DWORD GetActualAddressFromRVA(IMAGE_SECTION_HEADER *pSectionHeader,
							  IMAGE_NT_HEADERS *pNTHeaders, DWORD dwRVA);

// https://www.codeguru.com/cpp/w-p/dll/openfaq/article.php/c14001/Determining-Whether-a-DLL-or-EXE-Is-a-Managed-Component.htm#page-1
BOOL IsManaged(boost::filesystem::path lpszImageName);

// https://www.codeproject.com/tips/333559/WebControls/
BOOL executeCommandLine(std::wstring cmdLine, DWORD &exitCode);

//https://stackoverflow.com/questions/3790613/how-to-convert-a-string-of-hex-values-to-a-string
unsigned char hexval(unsigned char c);
void hex2ascii(const std::string &in, std::string &out);

//https://stackoverflow.com/questions/2933295/embed-text-file-in-a-resource-in-a-native-windows-application
void LoadFileInResource(int name, int type, std::string &data);

void find_files(std::list<boost::filesystem::path> &paths,
				boost::filesystem::path dest_dir,
				boost::filesystem::path name);

void removestr(std::string &str, const std::string &begin_tok, const std::string &end_tok);
