@ECHO OFF
REM -------------------------------------------------------------------
REM CMD_Here
REM Helper Batch File to set the configuration (environment)
REM		for the CMD_Here.bat
REM	Copyright (c) 2025 Adisak Pochanayon (adisak@gmail.com)
REM -------------------------------------------------------------------

REM call :SetScriptPath

REM -------------------------------------------------------------------

GOTO :SKIP_CONFIGURATION_MESSAGE
if NOT "%CH_CONFIG_HAS_RUN%"=="1" (
	echo Setting up CMD_Here configuration
) else (
	echo CMD_Here has already been configured
)
:SKIP_CONFIGURATION_MESSAGE

REM -------------------------------------------------------------------

REM Optional check below to prevent re-running configuration
if "%CH_CONFIG_ALLOW_RERUN%"=="1" GOTO :SKIP_PREVENT_RERUN
if "%CH_CONFIG_HAS_RUN%"=="1"  (
	echo CMD_Here has already been configured:
	echo     "%CH_PATH%\CH_UserConfig.bat"
	echo     will not be run. Run manually if required.
	GOTO :EXIT_BAT
)
:SKIP_PREVENT_RERUN

REM -------------------------------------------------------------------

REM This section of the BATCH File can be modified by user for
REM however they'd like to configure their working environment
REM Or, you can use a lighter weight "CH_UserConfig.bat" file
REM that will be run after the user configurations in this file.

REM Example: Set the Text Color to Green on a Black Background
REM COLOR 0A

REM Run the CH_UserConfig.bat if it exists
if EXIST "%CH_PATH%\CH_UserConfig.bat" (
	call "%CH_PATH%\CH_UserConfig.bat"
)

REM -------------------------------------------------------------------

set CH_CONFIG_HAS_RUN=1
:EXIT_BAT
GOTO :EOF

REM -------------------------------------------------------------------
REM Subroutines
REM -------------------------------------------------------------------

REM ":SetScriptPath" works in cases when use of %~dp0 might fail if this script was called with quotes
REM See: https://stackoverflow.com/questions/12141482/what-is-the-reason-for-batch-file-path-referenced-with-dp0-sometimes-changes-o
:SetScriptPath
if "%1"=="" GOTO :SSP_Implicit
call :SetToFullyExpandedPath %1 "%~dp0"
GOTO :EOF
:SSP_Implicit
call :SetToFullyExpandedPath SCRIPT_PATH "%~dp0"
GOTO :EOF

REM Fully Expand a Path
:SetToFullyExpandedPath
set "%1=%~f2"
GOTO :EOF

REM ---------------------------------------------

:AddToPath
if "%~1"=="" GOTO :EOF
if "%PATH%"=="" GOTO :ATP_EmptyPath
SETLOCAL
call :SetToFullyExpandedPath ADD_PATH "%~1"
if NOT "%PATH:~-1%"==";" set ADD_PATH=;%ADD_PATH%
ENDLOCAL & set PATH=%PATH%%ADD_PATH%
GOTO :EOF
:ATP_EmptyPath
call :SetToFullyExpandedPath PATH "%~1"
GOTO :EOF

REM ---------------------------------------------
REM Useful Helper for user to call conditionally-existing scripts
:CallIfBatExists
where "%~1" >NUL
if "%ERRORLEVEL%"=="0" call %*
GOTO :EOF
