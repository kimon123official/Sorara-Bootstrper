@echo off
setlocal

:: Variables
set "DOWNLOADS_DIR=%USERPROFILE%\Downloads"
set "GITHUB_RAW_URL=https://raw.githubusercontent.com/kimon123official/Sorara-Bootstrper/refs/heads/main/sorara.zip"
set "LOCAL_FILE=%DOWNLOADS_DIR%\sorara.zip"
set "SORARA_FOLDER=%DOWNLOADS_DIR%\sorara"

:: Ensure Downloads directory exists
if not exist "%DOWNLOADS_DIR%" (
    echo Downloads directory does not exist. Exiting...
    exit /b 1
)

:: Delete old file and folder if they exist
call :DeleteOldFilesAndFolders

:: Download the file
call :DownloadFile

:: Wait for 1 second
ping -n 2 127.0.0.1 >nul

:: Extract the ZIP file
call :ExtractZipFile

:: Open the extracted folder
call :OpenExtractedFolder

:: End script
echo Task completed.
exit /b

:: Function to delete old files and folders
:DeleteOldFilesAndFolders
if exist "%LOCAL_FILE%" (
    del /f /q "%LOCAL_FILE%"
    echo Old ZIP file deleted.
)

if exist "%SORARA_FOLDER%" (
    rmdir /s /q "%SORARA_FOLDER%"
    echo 'sorara' folder deleted.
)
goto :eof

:: Function to download the file from GitHub
:DownloadFile
echo Downloading file from GitHub...
curl -L -o "%LOCAL_FILE%" "%GITHUB_RAW_URL%"
if %ERRORLEVEL% neq 0 (
    echo Failed to download the file.
    exit /b 1
)
echo File downloaded successfully.
goto :eof

:: Function to extract the ZIP file
:ExtractZipFile
echo Extracting ZIP file...
powershell -command "Expand-Archive -Path '%LOCAL_FILE%' -DestinationPath '%SORARA_FOLDER%'"
if %ERRORLEVEL% neq 0 (
    echo Failed to extract the ZIP file.
    exit /b 1
)
echo ZIP file extracted successfully.

:: Delete the ZIP file after extraction
del /f /q "%LOCAL_FILE%"
echo ZIP file deleted after extraction.
goto :eof

:: Function to open the extracted folder
:OpenExtractedFolder
echo Opening the extracted folder...
start "" "%SORARA_FOLDER%"
goto :eof
