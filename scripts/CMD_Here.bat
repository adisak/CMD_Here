@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
REM -------------------------------------------------------------------
REM Helper Batch File to start a CMD Window with current directory set
REM		to same directory as this Batch File
REM	Copyright (c) 2023 Adisak Pochanayon (adisak@gmail.com)
REM -------------------------------------------------------------------

call :SetToFullyExpandedPath SCRIPT_PATH "%~dp0"

REM Use 'SET CH_OPEN_NEW_WINDOW=1' if you always want to open a new window
REM Use 'SET CH_OPEN_NEW_WINDOW=0' if you want to reuse CMD windows when you call
REM		CMD_Here.bat for the first time (subsequent calls will open new windows)
SET CH_OPEN_NEW_WINDOW=0
if "%IS_CH_WINDOW%"=="1" (
	REM If we're already in a CMD_Here window, then open a new one
	SET CH_OPEN_NEW_WINDOW=1
)
SET IS_CH_WINDOW=1

REM -------------------------------------------------------------------

REM Optional: Override Command Line Working Window Title Here
REM set CH_TITLE=Preset Window Name
set CH_TITLE=

REM Set the CH Directory variable (CH_WINDOW_DIR)
REM If Window Title isn't specified, set it to last path of current directory or script path as fallback
set CH_WINDOW_DIR=%SCRIPT_PATH%
if "%CH_WINDOW_DIR:~-1%" == "\" set CH_WINDOW_DIR=%CH_WINDOW_DIR:~0,-1%
if "%CH_WINDOW_DIR:~-1%" == ":" (
	set CH_WINDOW_DIR=%SCRIPT_PATH%
	if "%CH_TITLE%"=="" GOTO :DEFAULT_TITLE
)
if NOT "%CH_TITLE%"=="" GOTO :DONE_WITH_TITLE
for %%I in ("%CH_WINDOW_DIR%") do set CH_TITLE=%%~nxI
if NOT "%CH_TITLE%"=="" GOTO :DONE_WITH_TITLE

REM Set window title to a boring default value
:DEFAULT_TITLE
REM set CH_TITLE=%ComSpec%
set CH_TITLE=Command Window at %SCRIPT_PATH%

:DONE_WITH_TITLE

REM -------------------------------------------------------------------

set CH_CONFIG=%SCRIPT_PATH%\CH_Config.bat

if "%CH_OPEN_NEW_WINDOW%"=="1" GOTO :OPEN_NEW_WINDOW

:USE_EXISTING_WINDOW
if EXIST "%CH_CONFIG%" (
	call :ClearCHVars & CMD /K TITLE %CH_TITLE% ^& cd /D "%CH_WINDOW_DIR%" ^& "%CH_CONFIG%"
) else (
	call :ClearCHVars & CMD /K TITLE %CH_TITLE% ^& cd /D "%CH_WINDOW_DIR%"
)

GOTO :DONE_WITH_WINDOW

:OPEN_NEW_WINDOW
if EXIST "%CH_CONFIG%" (
	call :ClearCHVars & start "%CH_TITLE%" /D "%CH_WINDOW_DIR%" CMD /K TITLE %CH_TITLE% ^& "%CH_CONFIG%"
) else (
	call :ClearCHVars & start "%CH_TITLE%" /D "%CH_WINDOW_DIR%" CMD /K TITLE %CH_TITLE%
)

:DONE_WITH_WINDOW

REM -------------------------------------------------------------------

:EXIT_BAT
ENDLOCAL
GOTO:EOF

REM ---------------------------------------------
REM Subroutines
:SetToFullyExpandedPath
set %1=%~f2
goto:EOF

:ClearCHVars
set CH_OPEN_NEW_WINDOW=
set CH_TITLE=
set CH_CONFIG=
set CH_WINDOW_DIR=
goto:EOF