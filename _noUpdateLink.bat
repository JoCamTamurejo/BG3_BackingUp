@echo off
echo Create links to the fixed/working version of baldurs gate
set mypath=%0\..\
if exist %mypath%bin_noUpdate (
  rmdir %mypath%\bin /s /q
  rmdir %mypath%\Data /s /q
  mklink /D %mypath%\bin %mypath%\bin_noUpdate
  mklink /D %mypath%\Data %mypath%\Data_noUpdate
) else (
  echo No local copy found
)

echo noUpdate Linking done
pause
