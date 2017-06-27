@echo off
::Windows XP doesn't have UAC so skip
for /f "tokens=3*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| "%SYSTEM%Find" "ProductName"') do set WINVER=%%i %%j 
echo %WINVER% | find "XP" > nul && goto commands
::prompt for elevation
if "%1" == "UAC" goto elevation
(
  echo Set objShell = CreateObject^("Shell.Application"^)
  echo Set objFSO = CreateObject^("Scripting.FileSystemObject"^)
  echo strPath = objFSO.GetParentFolderName^(WScript.ScriptFullName^)
  echo If objFSO.FileExists^("%~dpnx0"^) Then
  echo   objShell.ShellExecute "cmd.exe", "/c """"%~dpnx0"" UAC ""%~dp0""""", "", "runas", 1
  echo Else
  echo   MsgBox "Script file not found"
  echo End If
) > "%TEMP%\UAC.vbs"
cscript //nologo %TEMP%\UAC.vbs
goto :eof
:elevation
del /q "%TEMP%\UAC.vbs"
 
:commands
::navigate back to this script's home folder
%~d2
cd "%~p2"
 
::put your main script here
netsh firewall add allowedprogram "%~dp0p\Advanced Combat Tracker.exe" ACTv3 ENABLE
netsh advfirewall firewall  add rule name="ACTv3" dir=in action=allow program="%~dp0p\Advanced Combat Tracker.exe" enable=yes
@echo off
::Windows XP doesn't have UAC so skip
for /f "tokens=3*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| "%SYSTEM%Find" "ProductName"') do set WINVER=%%i %%j 
echo %WINVER% | find "XP" > nul && goto commands
::prompt for elevation
if "%1" == "UAC" goto elevation
(
  echo Set objShell = CreateObject^("Shell.Application"^)
  echo Set objFSO = CreateObject^("Scripting.FileSystemObject"^)
  echo strPath = objFSO.GetParentFolderName^(WScript.ScriptFullName^)
  echo If objFSO.FileExists^("%~dpnx0"^) Then
  echo   objShell.ShellExecute "cmd.exe", "/c """"%~dpnx0"" UAC ""%~dp0""""", "", "runas", 1
  echo Else
  echo   MsgBox "Script file not found"
  echo End If
) > "%TEMP%\UAC.vbs"
cscript //nologo %TEMP%\UAC.vbs
goto :eof
:elevation
del /q "%TEMP%\UAC.vbs"
 
:commands
::navigate back to this script's home folder
%~d2
cd "%~p2"
@echo on
::put your main script here
netsh advfirewall firewall delete rule "name=ACTv3"
netsh firewall add allowedprogram "%~dp0Advanced Combat Tracker.exe" ACTv3 ENABLE
netsh advfirewall firewall  add rule name="ACTv3" dir=in action=allow program="%~dp0Advanced Combat Tracker.exe" enable=yes
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%~dp0Advanced Combat Tracker.exe" /t REG_SZ /d "~ RUNASADMIN" /f
pause
