@echo off
echo "Kill SuperApplication.exe"
C:\pstools\pskill.exe -t \\REMOTE-HOST -u REMOTE-HOST\Administrator -p SuperPassword SuperApplication.exe

echo "Get session ID"
C:\pstools\psexec.exe \\REMOTE-HOST -i -u REMOTE-HOST\Administrator -p SuperPassword cmd /C "@echo off & for /F "usebackq tokens=1,2,3,4,5*" %i in (`qwinsta Administrator ^| find "Active"`) do if "%l" == "Active" (echo %k & exit /b %k)" 
echo "Session ID:" %errorlevel%

echo "Run SuperApplication.exe"
C:\pstools\psexec.exe \\REMOTE-HOST -i %errorlevel% -u REMOTE-HOST\Administrator -p SuperPassword -d C:\SuperApplication.exe
REM pause