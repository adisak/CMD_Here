@ECHO OFF
REM -------------------------------------------------------------------
REM CMD_Here
REM Helper Batch File to set the configuration (environment)
REM		for the CMD_Here.bat
REM	Copyright (c) 2025 Adisak Pochanayon (adisak@gmail.com)
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

REM Run the CH_UserConfig.bat if it exists
if EXIST "%CH_PATH%\CH_UserConfig.bat" (
	call "%CH_PATH%\CH_UserConfig.bat"
)

REM -------------------------------------------------------------------
set CH_CONFIG_HAS_RUN=1
:EXIT_BAT
GOTO :EOF
