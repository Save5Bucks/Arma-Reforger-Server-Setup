@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

REM Jump to the first step
goto STEP1

REM -----------------------------------------------------------------------------
REM  2. HEADER (WITHOUT CLS)
REM -----------------------------------------------------------------------------
:PRINT_HEADER
echo.
echo                                 ┏━━━┓╋╋╋╋╋╋╋╋┏━━━┓╋╋╋┏━┓
echo                                 ┃┏━┓┃╋╋╋╋╋╋╋╋┃┏━┓┃╋╋╋┃┏┛
echo                                 ┃┃╋┃┣━┳┓┏┳━━┓┃┗━┛┣━━┳┛┗┳━━┳━┳━━┳━━┳━┓
echo                                 ┃┗━┛┃┏┫┗┛┃┏┓┃┃┏┓┏┫┃━╋┓┏┫┏┓┃┏┫┏┓┃┃━┫┏┛
echo                                 ┃┏━┓┃┃┃┃┃┃┏┓┃┃┃┃┗┫┃━┫┃┃┃┗┛┃┃┃┗┛┃┃━┫┃
echo                                 ┗┛╋┗┻┛┗┻┻┻┛┗┛┗┛┗━┻━━┛┗┛┗━━┻┛┗━┓┣━━┻┛
echo                                 ╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋┏━┛┃
echo                                 ╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋┗━━┛
echo.
echo                             Welcome to the ArmA Reforger Server Installer 
echo                             by Save5Bucks
echo.
goto :EOF

REM -----------------------------------------------------------------------------
REM  3. MAIN FLOW
REM -----------------------------------------------------------------------------
:STEP0
cls
call :PRINT_HEADER
echo We will guide you through the setup steps.
echo.
echo Press ENTER to continue...
pause >nul

goto STEP1

REM ---------------------------------------------------------------------------
REM  STEP 1 - Drive Letter
REM ---------------------------------------------------------------------------
:STEP1
cls
call :PRINT_HEADER
echo.
echo ---------------------------------------------------------------------------
echo [STEP 1] - Enter the drive letter you want to use (e.g., C):
echo ---------------------------------------------------------------------------
echo.
set /p DriveLetter="Drive Letter: "

IF NOT EXIST "%DriveLetter%:\" (
    echo.
    echo Invalid drive letter "%DriveLetter%:". Please enter a valid drive.
    echo Press ENTER to retry...
    pause >nul
    goto STEP1
)

:: Setup the base path
set ServerBase=%DriveLetter%:\Arma_Reforger
set /a Counter=0

goto STEP2

REM ---------------------------------------------------------------------------
REM  STEP 2 - Create or find an available folder named "Server_#"
REM ---------------------------------------------------------------------------
:STEP2
cls
call :PRINT_HEADER
echo.
echo ---------------------------------------------------------------------------
echo [STEP 2] - Creating a new server directory - Server_0 is default
echo            If you already have a server it will add 1 to Sever_#
echo ---------------------------------------------------------------------------
echo.

:CHECK_FOLDER
set ServerPath=%ServerBase%\Server_%Counter%

:ASK_CHOICE
    echo Would you like to add the Server Folder? (Y/N)
    set /p AddNew="Choice: "

REM If the folder already exists, ask user if they want to make another folder
if exist "%ServerPath%" (
    echo Folder "Server_%Counter%" already exists.
    if /I "%AddNew%"=="Y" (
        set /a Counter+=1
        goto CHECK_FOLDER
    ) else if /I "%AddNew%"=="N" (
        echo Exiting setup...
        pause
        goto THE_END
    ) else (
        echo Invalid choice. Please enter Y or N.
        pause
        goto ASK_CHOICE
    )
)

REM If the folder does not exist, create it
mkdir "%ServerPath%"
echo Created folder: %ServerPath%
echo.
pause

goto STEP3

REM ---------------------------------------------------------------------------
REM  STEP 3 - Download/Extract SteamCMD if missing
REM ---------------------------------------------------------------------------
:STEP3
cls
call :PRINT_HEADER
echo.
echo ---------------------------------------------------------------------------
echo [STEP 3] - Checking for SteamCMD in "%ServerPath%\SteamCMD"
echo ---------------------------------------------------------------------------
echo.

set SteamCMDPath=%ServerPath%\SteamCMD

if not exist "%SteamCMDPath%" (
    echo SteamCMD not found. Downloading SteamCMD...
    mkdir "%SteamCMDPath%"
    powershell -Command ^
        "(New-Object System.Net.WebClient).DownloadFile('https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip','%SteamCMDPath%\steamcmd.zip')" 

    echo Download complete.
    echo Press ENTER to extract SteamCMD and install...
    pause >nul

    cls
    call :PRINT_HEADER
    echo Extracting SteamCMD to "%SteamCMDPath%"...
    powershell -Command ^
        "Expand-Archive -Path '%SteamCMDPath%\steamcmd.zip' -DestinationPath '%SteamCMDPath%' -Force"

    echo Extraction complete.
    echo.
)

goto STEP4

REM ---------------------------------------------------------------------------
REM  STEP 4 - Install/Update ArmA Reforger
REM ---------------------------------------------------------------------------
:STEP4
cls
call :PRINT_HEADER
echo.
echo ---------------------------------------------------------------------------
echo [STEP 4] - Installing/Updating ArmA Reforger Server
echo ---------------------------------------------------------------------------
echo.

"%SteamCMDPath%\steamcmd.exe" ^
  +force_install_dir "%ServerPath%" ^
  +login anonymous ^
  +app_update 1874900 validate ^
  +quit

echo.
echo Press ENTER to continue...
pause >nul
goto STEP5

REM ---------------------------------------------------------------------------
REM  STEP 5 - Base config
REM ---------------------------------------------------------------------------
:STEP5
cls
call :PRINT_HEADER
echo.
echo ---------------------------------------------------------------------------
echo [STEP 5] - Create a base config file? (Y/N)
echo ---------------------------------------------------------------------------
echo.
set /p CreateConfig="Choice: "

if /I "%CreateConfig%"=="Y" (
    echo Creating "config.json" in "%ServerPath%".
    (
        echo {
        echo     "dedicatedServerId": "",
        echo     "region": "",
        echo     "gameHostBindAddress": "",
        echo     "gameHostBindPort": 2001,
        echo     "gameHostRegisterBindAddress": "",
        echo     "gameHostRegisterPort": 2001,
        echo     "game": {
        echo         "name": "",
        echo         "password": "",
        echo         "scenarioId": "",
        echo         "playerCountLimit": 127,
        echo         "visible": true,
        echo         "gameProperties": {
        echo             "serverMaxViewDistance": 1600,
        echo             "serverMinGrassDistance": 0,
        echo             "networkViewDistance": 0,
        echo             "disableThirdPerson": false,
        echo             "fastValidation": true,
        echo             "battlEye": true
        echo         },
        echo         "mods": []
        echo     }
        echo }
    ) > "%ServerPath%\config.json"

    echo Config file created: %ServerPath%\config.json
    echo.
)

echo Press ENTER to continue...
pause >nul
goto STEP6

REM ---------------------------------------------------------------------------
REM  STEP 6 - Add Firewall Rules
REM ---------------------------------------------------------------------------
:STEP6
cls
call :PRINT_HEADER
echo.
echo ---------------------------------------------------------------------------
echo [STEP 6] - Add firewall rules for the necessary game ports? (Y/N)
echo ---------------------------------------------------------------------------
echo.
echo The following UDP ports need to be opened for public servers:
echo - 2001 (Game Port)
echo - 17777 (Steam Query Port)
echo.
set /p AddFirewall="Choice (Y/N): "

:: If user selects "Y", add firewall rules
if /I "%AddFirewall%"=="Y" (
    echo Adding firewall rules...
    netsh advfirewall firewall add rule name="ArmA Reforger Game IN" dir=in action=allow protocol=UDP localport=2001
    netsh advfirewall firewall add rule name="ArmA Reforger SteamQuery IN" dir=in action=allow protocol=UDP localport=17777
    netsh advfirewall firewall add rule name="ArmA Reforger Game OUT" dir=out action=allow protocol=UDP localport=2001
    netsh advfirewall firewall add rule name="ArmA Reforger SteamQuery OUT" dir=out action=allow protocol=UDP localport=17777
    echo ✅ Firewall rules added successfully.
    pause
    goto STEP7
)

:: If user selects "N", skip firewall rules
if /I "%AddFirewall%"=="N" (
    echo ❌ Skipping firewall rules. You will need to add them manually.
    pause
    goto STEP7
)

:: If input is invalid, ask again
echo ❗ Invalid choice. Please enter Y or N.
pause
goto ASK_FIREWALL

goto STEP7

REM ---------------------------------------------------------------------------
REM  STEP 7 - Create start.bat
REM ---------------------------------------------------------------------------
:STEP7
cls
call :PRINT_HEADER
echo.
echo ---------------------------------------------------------------------------
echo [STEP 7] - Create "start.bat" to run the server? (Y/N)
echo ---------------------------------------------------------------------------
echo.
set /p CreateStart="Choice: "

if /I "%CreateStart%"=="Y" (
    echo Creating "start.bat" in "%ServerPath%".
    (
        echo @echo off
        echo title ArmA Reforger Server
        echo chcp 65001 ^>nul
        echo setlocal EnableDelayedExpansion
        echo.
        echo echo Checking for updates...
        echo "%SteamCMDPath%\steamcmd.exe" +force_install_dir "%ServerPath%" +login anonymous +app_update 1874900 validate +quit
        echo echo Server is up to date!
        echo.
        echo :RESTART
        echo echo Starting the server...
        echo start /wait "" "%ServerPath%\ArmaReforgerServer.exe" -maxFPS 60 -config ".\config.json"
        echo echo [LOG - %%date%% %%time%%] - Server closed with exit code !ERRORLEVEL! ^>^> "%ServerPath%\server.log"
        echo ^( if !ERRORLEVEL! NEQ 0 echo [LOG - %%date%% %%time%%] - Server crashed ^>^> "%ServerPath%\server.log" ^)
        echo ^( if !ERRORLEVEL! EQU 0 echo [LOG - %%date%% %%time%%] - Server stopped gracefully ^>^> "%ServerPath%\server.log" ^)
        echo echo Server will restart in 5 seconds...
        echo timeout /t 5 /nobreak ^>nul
        echo goto RESTART
    ) > "%ServerPath%\start.bat"

    echo.
    echo ✅ start.bat created successfully: "%ServerPath%\start.bat"
)

echo.
echo Press ENTER to continue...
pause >nul
goto FINAL

REM ---------------------------------------------------------------------------
REM  FINAL
REM ---------------------------------------------------------------------------
:FINAL
cls
call :PRINT_HEADER
echo.
echo ---------------------------------------------------------------------------
echo              Congratulations! Your ArmA Reforger Server
echo                   has been successfully installed!
echo ---------------------------------------------------------------------------
echo.
echo Your server folder:
echo   %ServerPath%
echo.
echo To run your server, open "%ServerPath%" and run:
echo   start.bat
echo.
echo Press ENTER to open the server folder...
pause >nul
explorer "%ServerPath%"

:THE_END
echo.
echo Press ENTER to finish and close...
pause >nul

REM Keep the window open instead of closing automatically:
cmd /k
endlocal
exit /b
