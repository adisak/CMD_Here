@ECHO OFF
REM -------------------------------------------------------------------
REM Helper Batch File to set the configuration (environment)
rem		for the CMD_Here.bat
REM	Copyright (c) 2023 Adisak Pochanayon (adisak@gmail.com)
REM -------------------------------------------------------------------

REM This section of the BATCH File can be modified by user for
REM however they'd like to configure their working environement

REM call :SetToFullyExpandedPath SCRIPT_PATH "%~dp0"

REM Set the Text Color to Green on a Black Background
COLOR 0A

REM -------------------------------------------------------------------

:EXITBAT
GOTO:EOF

REM ---------------------------------------------
REM Subroutines

REM Fully Expand a Path
:SetToFullyExpandedPath
set %1=%~f2
goto:EOF

REM ---------------
REM Clean up CH_* variables from CMD_Here
:ClearCHVars
set CH_WINDOW=
set CH_TITLE=
set CH_CONFIG=
set CH_WINDOW_DIR=
goto:EOF
