@echo off
pause
echo Save current bin and Data folders
set mypath=%~dp0
echo "%mypath%"
if exist "%mypath%bin_noUpdate" (
  rmdir "%mypath%bin_noUpdate" /s /q
  rmdir "%mypath%Data_noUpdate" /s /q
)
robocopy "%mypath%bin" "%mypath%bin_noUpdate" /s /e
robocopy "%mypath%Data" "%mypath%Data_noUpdate" /s /e
rename "%mypath%bin" bin_original
rename "%mypath%Data" Data_original
pause
