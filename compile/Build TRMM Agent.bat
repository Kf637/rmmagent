@echo off
:: ChatGPT rewrite
cls
echo No support is available, this script is provided as-is and is NOT made by AmidaWare (Tactical RMM).
echo.
:: Check if script is running in windows
if not "%OS%"=="Windows_NT" (
    echo This script is only supported on Windows. Please refer to the docs or run the script on a Windows VM. Exiting...
    pause
    exit /b
)
:: Get the username of the current user
set USERNAME=%USERNAME%
:: Set to user's home directory as most users just clone to their home directory
set TARGET_DIR=C:\Users\%USERNAME%\rmmagent
set VERSION=v2.8.0

:: Check if Git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git is not installed. Please install Git at https://git-scm.com/downloads and try again. Exiting...
    pause
    exit /b
) else (
    git --version
)

:: Check if Go is installed
go version >nul 2>&1
if %errorlevel% neq 0 (
    echo Go is not installed. Please install Go at https://go.dev/doc/install and try again. Exiting...
    pause
    exit /b
) else (
    go version
)

:: Check if the directory exists
if not exist "%TARGET_DIR%" (
    echo Directory "%TARGET_DIR%" does not exist. Cloning repository...
    git clone https://github.com/amidaware/rmmagent "%TARGET_DIR%"
    if %errorlevel% neq 0 (
        echo Failed to clone repository, make sure git is installed. Exiting...
        pause
        exit /b
    )
) else (
    echo Directory "%TARGET_DIR%" already exists.
)

:: Navigate to the target directory
cd /d "%TARGET_DIR%"
if %errorlevel% neq 0 (
    echo Failed to navigate to "%TARGET_DIR%". Exiting...
    pause
    exit /b
)

:: Menu for build options
echo ============================
echo Select OS and Architecture:
echo ============================
echo 1 = Windows 64-bit
echo 2 = Windows 32-bit
echo 3 = Linux 64-bit
echo 4 = Linux 32-bit
echo 5 = Linux ARM
:: macOS havent been tested yet (dont have a mac, Apple is expensive $$$)
echo 6 = macOS Intel (amd64)
echo 7 = macOS Apple M series (arm64)
echo 10 = Info
echo 11 = Delete and re-clone the repository in %TARGET_DIR%
echo ============================
set /p choice="Enter the number for your target: "
:: Clear terminal
cls
if "%choice%"=="1" (
    set GOOS=windows
    set GOARCH=amd64
    set EXT=.exe
) else if "%choice%"=="2" (
    set GOOS=windows
    set GOARCH=386
    set EXT=.exe
) else if "%choice%"=="3" (
    set GOOS=linux
    set GOARCH=amd64
    set EXT=
) else if "%choice%"=="4" (
    set GOOS=linux
    set GOARCH=386
    set EXT=
) else if "%choice%"=="5" (
    set GOOS=linux
    set GOARCH=arm
    set EXT=
) else if "%choice%"=="6" (
    set GOOS=darwin
    set GOARCH=amd64
    set EXT=
) else if "%choice%"=="7" (
    set GOOS=darwin
    set GOARCH=arm64
    set EXT=
) else if "%choice%"=="10" (
    cls
    echo The macOS build has not been tested yet.
    echo.
    echo If you have a Raspberry Pi, you can use the Linux ARM build. If you are unsure what architecture you have, you can use the uname -m command.
    echo.
    echo Building the file yourself is not supported by the developers of Tactical RMM and no help is available
    echo Current commit hash:
    git rev-parse --short HEAD
    pause
    call %0
) else if "%choice%"=="11" (
    echo Current commit hash:
    git rev-parse --short HEAD
    echo Deleting %TARGET_DIR% and re-cloning the repository to C:\Users\%USERNAME%\rmmagent.. Please wait..

    set TARGET_DIR=C:\Users\%USERNAME%\rmmagent

    :retry
    cd /d %TEMP%
    timeout /t 5 /nobreak >nul
    rmdir /s /q "%TARGET_DIR%"
    if exist "%TARGET_DIR%" (
        echo Waiting for directory to be released...
        goto retry
    )
    git clone https://github.com/amidaware/rmmagent "%TARGET_DIR%"
    echo Repository re-cloned successfully, setting target directory to %TARGET_DIR%
    echo Target directory set to %TARGET_DIR%
    pause
    call %0
) else (
    echo Invalid choice.
    pause
    call %0
)

set CGO_ENABLED=0
set LDFLAGS=-s -w

:: Build the application
cls
echo Building for %GOOS% %GOARCH%...
go build -ldflags "%LDFLAGS%"
if %errorlevel% neq 0 (
    echo Build failed!
    pause
    call %0
)

:: Rename the output file
set OUTPUT_NAME=tacticalagent-%VERSION%-%GOOS%-%GOARCH%%EXT%
if exist rmmagent%EXT% (
    rename rmmagent%EXT% %OUTPUT_NAME%
    echo Build succeeded! Output: %OUTPUT_NAME%
) else (
    echo Build succeeded but output file not found. Manual renaming required.
    pause
    call %0
)

:: Ask where to move the file
echo ============================
echo Where do you want to move the file?
echo 1 = Move to Downloads
echo 2 = Move to Desktop
echo 3 = Do not move (file will remain in the current directory)
echo ============================
set /p moveChoice="Enter your choice: "

if "%moveChoice%"=="1" (
    set DEST_DIR=C:\Users\%USERNAME%\Downloads
) else if "%moveChoice%"=="2" (
    set DEST_DIR=C:\Users\%USERNAME%\Desktop
) else if "%moveChoice%"=="3" (
    echo File will remain in the current directory.
    pause
    call %0
) else (
    echo Invalid choice, file will remain in the current directory. Exiting...
    pause
    call %0
)

:: Move the file
if not exist "%DEST_DIR%" (
    echo Destination directory "%DEST_DIR%" does not exist. You can find the file in C:\Users\%USERNAME%\rmmagent
)

move "%OUTPUT_NAME%" "%DEST_DIR%"
if %errorlevel%==0 (
    echo File successfully moved to "%DEST_DIR%".
) else (
    echo Failed to move the file.
)

pause
call %0