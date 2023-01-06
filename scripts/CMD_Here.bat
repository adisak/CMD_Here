@ECHO OFF
SETLOCAL
REM -------------------------------------------------------------------
REM Helper Batch File to start a CMD Window with current directory set
REM		to same directory as this Batch File
REM	Copyright (c) 2023 Adisak Pochanayon (adisak@gmail.com)
REM -------------------------------------------------------------------

call :SetToFullyExpandedPath SCRIPT_PATH "%~dp0"

SET CH_WINDOW=/B
if "%IS_CH_WINDOW%"=="1" (
	SET CH_WINDOW=
)
SET IS_CH_WINDOW=1

REM -------------------------------------------------------------------

REM set CH_TITLE=Preset Window Name
set CH_TITLE=
if NOT "%CH_TITLE%"=="" GOTO :DONE_WITH_TITLE

REM Set window title to last path of current directory
set CH_WINDOW_DIR=%SCRIPT_PATH%
if "%CH_WINDOW_DIR:~-1%" == "\" set CH_WINDOW_DIR=%CH_WINDOW_DIR:~0,-1%
if "%CH_WINDOW_DIR:~-1%" == ":" (
	set CH_WINDOW_DIR=%SCRIPT_PATH%
	GOTO :DEFAULT_TITLE
)
for %%I in ("%CH_WINDOW_DIR%") do set CH_TITLE=%%~nxI
if NOT "%CH_TITLE%"=="" GOTO :DONE_WITH_TITLE

REM Set window title to a boring default value
:DEFAULT_TITLE
REM set CH_TITLE=%ComSpec%
set CH_TITLE=Command Window at %SCRIPT_PATH%

:DONE_WITH_TITLE

REM -------------------------------------------------------------------

set CH_CONFIG=%SCRIPT_PATH%\CH_Config.bat

if EXIST "%CH_CONFIG%" (
	call :ClearCHVars & start %CH_WINDOW% "%CH_TITLE%" CMD /K TITLE %CH_TITLE% ^&^& "%CH_CONFIG%"
) else (
	call :ClearCHVars & start %CH_WINDOW% "%CH_TITLE%" CMD /K TITLE %CH_TITLE%
)

REM -------------------------------------------------------------------

:EXITBAT
ENDLOCAL
GOTO:EOF

REM ---------------------------------------------
REM Subroutines
:SetToFullyExpandedPath
set %1=%~f2
goto:EOF

:ClearCHVars
set CH_WINDOW=
set CH_TITLE=
set CH_CONFIG=
set CH_WINDOW_DIR=
goto:EOF