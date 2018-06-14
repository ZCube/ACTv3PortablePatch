@echo off
set _ROOT=%CD%

python rev.py

mkdir build
pushd build

cmake -G "Visual Studio 15 2017" %_ROOT% ^
	"-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:PATH=%_ROOT%/bin" ^
	"-DCMAKE_LIBRARY_OUTPUT_DIRECTORY:PATH=%_ROOT%/lib" ^
	"-DCMAKE_RUNTIME_OUTPUT_DIRECTORY:PATH=%_ROOT%/bin" ^
	"-DUSE_SSL=ON"
  ..
cmake --build . --config Release
popd