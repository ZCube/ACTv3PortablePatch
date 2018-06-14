#include <Windows.h>
#include <boost/algorithm/string.hpp>
#include <boost/filesystem.hpp>
#include <boost/regex.hpp>
#include <cor.h>
#include <winnt.h>
#include <iostream>
#include "util.h"
#include "resource.h"

int main(int argc, char **argv)
{
	std::cout << "Advanced Combat Tracker v3 Portable Patch by zcube@zcube.kr" << std::endl;
	try
	{
		std::string getfolderpathil;
		LoadFileInResource(IDR_TEXT_GETFOLDERPATH, TEXTFILE, getfolderpathil);
		std::string savesettingsil;
		LoadFileInResource(IDR_TEXT_SETTINGS, TEXTFILE, savesettingsil);
		boost::filesystem::path temp_path =
			getenv("temp") ? getenv("temp")
						   : (getenv("tmp") ? getenv("tmp")
											: boost::filesystem::current_path());

		std::list<boost::filesystem::path> ildasms;
		if (getenv("ProgramFiles"))
			find_files(ildasms,
					   boost::filesystem::path(getenv("ProgramFiles")) / L"Microsoft SDKs" / L"Windows",
					   "ildasm.exe");
		if (getenv("ProgramFiles(x86)"))
			find_files(ildasms,
					   boost::filesystem::path(getenv("ProgramFiles(x86)")) / L"Microsoft SDKs" / L"Windows",
					   "ildasm.exe");
		ildasms.sort();
		ildasms.erase(std::unique(ildasms.begin(), ildasms.end()), ildasms.end());
		ildasms.erase(std::remove_if(ildasms.begin(), ildasms.end(),
									 [](boost::filesystem::path &p) {
										 return boost::find_first(p.string(), "x64");
									 }),
					  ildasms.end());

		std::vector<std::list<boost::filesystem::path>> ildasms_versions;
		std::vector<std::string> ildasms_versions_str = {" 4.9", " 4.8", " 4.7", " 4.6"};
		for (int i = 0; i < ildasms_versions_str.size(); ++i)
		{
			ildasms_versions.push_back(ildasms);
		}
		ildasms.clear();
		for (int i = 0; i < ildasms_versions_str.size(); ++i)
		{
			ildasms_versions[i].erase(
				std::remove_if(ildasms_versions[i].begin(), ildasms_versions[i].end(),
							   [ildasms_versions_str, i](boost::filesystem::path &p) {
								   return !(boost::find_first(p.string(),
															  ildasms_versions_str[i]));
							   }),
				ildasms_versions[i].end());
			if (!ildasms_versions[i].empty())
			{
				ildasms = ildasms_versions[i];
			}
		}

		std::list<boost::filesystem::path> ilasms;
		if (getenv("windir"))
			find_files(ilasms,
					   boost::filesystem::path(getenv("windir")) / L"Microsoft.NET",
					   "ilasm.exe");
		ilasms.sort();
		ilasms.erase(std::unique(ilasms.begin(), ilasms.end()), ilasms.end());
		ilasms.erase(std::remove_if(ilasms.begin(), ilasms.end(),
									[](boost::filesystem::path &p) {
										return !boost::find_first(p.string(),
																  "Framework");
									}),
					 ilasms.end());
		ilasms.erase(std::remove_if(ilasms.begin(), ilasms.end(),
									[](boost::filesystem::path &p) {
										return !boost::find_first(p.string(), "v4");
									}),
					 ilasms.end());

		if (ildasms.empty())
		{
			std::cerr << "ildasm not found" << std::endl;
			return -1;
		}
		if (ilasms.empty())
		{
			std::cerr << "ilasm not found" << std::endl;
			return -1;
		}

		try
		{
			boost::filesystem::path &ildasm = ildasms.front();
			boost::filesystem::path &ilasm = ilasms.front();

			boost::filesystem::path dest_dir = boost::filesystem::current_path();
			boost::filesystem::recursive_directory_iterator dir(dest_dir);

			std::list<boost::filesystem::path> paths;
			for (auto &&i : dir)
			{
				std::string extension = i.path().extension().string();
				boost::to_lower(extension);

				if (extension == ".dll" || extension == ".exe")
				{
					if (IsManaged(i.path()))
					{
						{
							paths.push_back(i.path());
						}
					}
				}
			}
			for (auto &&i : paths)
			{
				boost::filesystem::path ph = temp_path / boost::filesystem::unique_path("ActPortable-%%%%-%%%%-%%%%-%%%%");
				boost::filesystem::create_directories(ph);
				DWORD exitCode;
				boost::filesystem::path ilpath = ph / i.leaf();
				ilpath.replace_extension(".il");
				boost::filesystem::path respath = ilpath;
				respath.replace_extension(".res");

				{
					std::wstring cmd(L"\"");
					cmd += (ildasm.wstring() + L"\" \"" + i.wstring() + L"\" /nobar /out=\"" + ilpath.wstring() + L"\"");
					executeCommandLine(cmd, exitCode);
				}
				if (exitCode != 0)
				{
					exitCode = exitCode;
					boost::filesystem::remove_all(ph);
					continue;
				}
				bool changed = true;

				std::ifstream t(ilpath.wstring().c_str(),
								std::ios_base::binary | std::ios_base::in);
				std::string str((std::istreambuf_iterator<char>(t)),
								std::istreambuf_iterator<char>());
				t.close();
				boost::algorithm::replace_all(str, "\r\n", "\n");
				std::string bak = str;
				boost::algorithm::replace_all(
					str, ".publickeytoken = (A9 46 B6 1E 93 D9 78 68 )", "");

				if (ilpath.leaf() == "ACTx86.il")
				{
					boost::algorithm::replace_all(
						str,
						".custom instance "
						"void[mscorlib]System.Reflection.AssemblyDelaySignAttribute::."
						"ctor(bool) = (01 00 00 00 00) ",
						"");
				}
				if (ilpath.leaf() == "Advanced Combat Tracker.il")
				{
					boost::algorithm::replace_all(
						str,
						".custom instance "
						"void[mscorlib]System.Reflection.AssemblyDelaySignAttribute::."
						"ctor(bool) = (01 00 00 00 00) ",
						"");
					boost::algorithm::replace_all(str, ".corflags 0x00000009",
												  ".corflags 0x00000001");
					// version info
					boost::algorithm::replace_all(
						str, "[^,]+, \\?Version=([^,]+),.+=a946b61e93d97868",
						"(?:ACTx86.*|Advanced Combat Tracker.*), ?Version=([^,]+),.+");

					if (!boost::algorithm::find_first(str, "_LoadNewSettings"))
					{
						//== del
						// SaveNewSettings
						// LoadNewSettings
						removestr(str,
								  ".publickey = (00 24 00 00 04 80 00 00 94 00 00 00 06 02 "
								  "00 00   // .$..............",
								  "FB A1 F2 3E 53 BA 1D DD 44 A2 BC 36 1C 2D BF B3 ) // "
								  "...>S...D..6.-..");
						removestr(str,
								  "  .method assembly hidebysig instance void \n          "
								  "SaveNewSettings(string XmlFileName) cil managed",
								  "  } // end of method FormActMain::SaveNewSettings");
						removestr(str,
								  "  .method assembly hidebysig instance void \n          "
								  "LoadNewSettings(string XmlFileName) cil managed",
								  "  } // end of method FormActMain::LoadNewSettings");

						//== add
						// SaveNewSettings
						// LoadNewSettings
						// ChangeDirNameToPath
						// ChangeDirNameToVar
						//_LoadNewSettings
						//_SaveNewSettings
						std::string sig = "  } // end of method FormActMain::.ctor";
						auto it = boost::algorithm::find_first(str, sig);
						if (it)
						{
							std::string data = savesettingsil;
							boost::algorithm::replace_all(
								data, "GetExePath.Program",
								"Advanced_Combat_Tracker.FormActMain");
							str.insert(it.begin() + sig.size() - str.begin(), data.data(),
									   data.size());
						}
					}
				}

				if (boost::algorithm::find_first(str, "Advanced Combat Tracker") &&
					boost::algorithm::find_first(str, "GetFolderPath") &&
					!boost::algorithm::find_first(
						str, "System.EnvironmentMod::GetFolderPath"))
				{
					boost::algorithm::replace_all(
						str, "[mscorlib]System.Environment::GetFolderPath",
						"System.EnvironmentMod::GetFolderPath");
					auto it = boost::algorithm::find_first(str, ".class");
					std::string data = getfolderpathil;

					if (ilpath.leaf() == "ACTx86.il" ||
						ilpath.leaf() == "Advanced Combat Tracker.il")
					{
					}
					else
					{
						boost::algorithm::replace_all(data, "GetExecutingAssembly",
													  "GetEntryAssembly");
					}
					str.insert(it.begin() - str.begin(), data.data(), data.size());
				}

				changed = (bak.size() != str.size());

				if (changed)
				{
					std::cout << "Changed : " << i << std::endl;

					std::ofstream of(ilpath.wstring().c_str(),
									 std::ios_base::binary | std::ios_base::out);
					of.write(str.data(), str.size());
					of.close();

					std::wstring options =
						(i.extension().string() == ".dll") ? L" /DLL " : L"";
					if (boost::filesystem::exists(respath))
					{
						std::wstring cmd(L"\"");
						cmd += (ilasm.wstring() + L"\" " + options + L" \"" +
								ilpath.wstring() + L"\" /RESOURCE=\"" + respath.wstring() +
								L"\"");
						executeCommandLine(cmd, exitCode);
					}
					else
					{
						std::wstring cmd(L"\"");
						cmd += (ildasm.wstring() + L"\" \"" + i.wstring() +
								L"\" /RESOURCE=\"" + respath.wstring() + L"\"");
						executeCommandLine(cmd, exitCode);
					}
					if (exitCode != 0)
					{
						std::cerr << "error" << std::endl;
						exitCode = exitCode;
					}
					boost::filesystem::path out = ilpath;
					out.replace_extension(i.extension());
					boost::filesystem::copy_file(
						out, i, boost::filesystem::copy_option::overwrite_if_exists);
					boost::filesystem::remove_all(ph);
				}
				else
				{
					boost::filesystem::remove_all(ph);
				}
			}
		}
		catch (std::exception e)
		{
			std::cerr << "Exception : " << e.what() << std::endl;
		}
		catch (...)
		{
			std::cerr << "Exception : "
					  << "Unknown exception" << std::endl;
		}
	}
	catch (std::exception e)
	{
		std::cerr << "Exception : " << e.what() << std::endl;
	}
	catch (...)
	{
		std::cerr << "Exception : "
				  << "Unknown exception" << std::endl;
	}

	return 0;
}