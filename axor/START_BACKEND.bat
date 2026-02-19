@echo off
echo ========================================
echo   AXOR Backend Server
echo ========================================
echo.

cd axor_app_backend

echo Checking if node_modules exists...
if not exist "node_modules\" (
    echo Installing dependencies...
    call npm install
    echo.
)

echo Starting AXOR Backend Server...
echo Server will run on http://localhost:3000
echo.
echo Press Ctrl+C to stop the server
echo.

call npm start

pause