@echo off
pause
echo Save current bin and Data folders
set mypath=%0\..\
if exist %mypath%bin_noUpdate (
  rmdir %mypath%bin_noUpdate /s /q
  rmdir %mypath%Data_noUpdate /s /q
)
robocopy %mypath%bin %mypath%bin_noUpdate /s /e
robocopy %mypath%Data %mypath%Data_noUpdate /s /e
rename %mypath%bin %mypath%bin_original
rename %mypath%Data %mypath%Data_original
pause
