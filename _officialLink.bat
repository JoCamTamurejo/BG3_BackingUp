@echo off
echo Create links to the offical released version of baldurs gate
set mypath=%~dp0
if exist "%mypath%bin_original" (
  rmdir "%mypath%bin" /s /q
  rmdir "%mypath%Data" /s /q
  mklink /D "%mypath%bin" "%mypath%bin_original"
  mklink /D "%mypath%Data" "%mypath%Data_original"
) else (
  echo No local copy found
)

echo Official Linking done
pause
