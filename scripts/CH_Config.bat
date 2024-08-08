@ECHO OFF
REM -------------------------------------------------------------------
REM Helper Batch File to set the configuration (environment)
rem		for the CMD_Here.bat
REM	Copyright (c) 2023 Adisak Pochanayon (adisak@gmail.com)
REM -------------------------------------------------------------------

REM call :SetToFullyExpandedPath SCRIPT_PATH "%~dp0"

REM -------------------------------------------------------------------

GOTO :SKIP_CONFIGURATION_MESSAGE
if NOT "%CH_CONFIG_HAS_RUN%"=="1" (
	echo Setting up CMD_Here configuration
) else (
	echo CMD_Here has already been configured
)
:SKIP_CONFIGURATION_MESSAGE

REM -------------------------------------------------------------------

REM Optional line below to prevent re-running configuration
if "%CH_CONFIG_HAS_RUN%"=="1" GOTO :EXIT_BAT

REM This section of the BATCH File can be modified by user for
REM however they'd like to configure their working environment

REM Set the Text Color to Green on a Black Background
REM COLOR 0A

REM -------------------------------------------------------------------

:EXIT_BAT
SET CH_CONFIG_HAS_RUN=1
GOTO :EOF

REM -------------------------------------------------------------------
REM Subroutines

REM Fully Expand a Path
:SetToFullyExpandedPath
set %~1=%~f2
GOTO :EOF

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
:CallIfBatExists
where %1 >NUL
if "%ERRORLEVEL%"=="0" call %1
GOTO :EOF

REM ---------------------------------------------
REM Clean up CH_* variables from CMD_Here
:ClearCHVars
set CH_OPEN_NEW_WINDOW=
set CH_TITLE=
set CH_CONFIG=
set CH_WINDOW_DIR=
GOTO :EOF

