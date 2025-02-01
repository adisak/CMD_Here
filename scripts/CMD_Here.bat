@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
REM -------------------------------------------------------------------
REM CMD_Here
REM Helper Batch File to start a CMD Window with current directory set
REM		to same directory as this Batch File
REM	Copyright (c) 2025 Adisak Pochanayon (adisak@gmail.com)
REM -------------------------------------------------------------------

set CH_OLDPATH=%CH_PATH%
REM Get the path for THIS script
call :SetScriptPath CH_PATH
set CH_SCRIPT_PATH=%CH_PATH%

call :DetectFromWhere

REM -------------------------------------------------------------------

REM Optional handling if launched from another directory
call :SetToFullyExpandedPath CH_CD "%CD%"

REM Allow CD to be used if launched by click (including shortcut)
REM or if explicitly requested
if /I "%~1"=="USE_CD" (
	set CH_USE_CD=1
) else if "%CH_FROM_EXPLORER%"=="1" (
	set CH_USE_CD=1
)

REM call :DebugCmdLine

if NOT "%CH_PATH%"=="%CH_CD%" (
	if "%CH_USE_CD%"=="1" (
		set CH_PATH=%CH_CD%
	) 
)

REM -------------------------------------------------------------------

REM Use 'set CH_OPEN_NEW_WINDOW=1' if you always want to open a new window
REM Use 'set CH_OPEN_NEW_WINDOW=0' if you want to reuse CMD windows when you call
REM		CMD_Here.bat for the first time (subsequent calls will open new windows)
if "%CH_OPEN_NEW_WINDOW%"=="" (
	if "%CH_OLDPATH%"=="" (
		set CH_OPEN_NEW_WINDOW=0
	) else (
		REM If we're already in a CMD_Here window, then open a new one
		set CH_OPEN_NEW_WINDOW=1
	)
)

if NOT "%CH_OLDPATH%"=="%CH_PATH%" (
	REM If we are running CMD_Here to open in a different directory
	REM (than the previous CMD_Here if it was run before), then
	REM clear the flag that says the CH_Config has already run
	set CH_CONFIG_HAS_RUN=
)

REM -------------------------------------------------------------------

REM Optional: Override Command Line Working Window Title Here
REM set CH_TITLE=Preset Window Name
set CH_TITLE=

REM Set the CH Directory variable (CH_WINDOW_DIR)
REM If Window Title isn't specified, set it to last path of current directory or script path as fallback
set CH_WINDOW_DIR=%CH_PATH%
if "%CH_WINDOW_DIR:~-1%" == "\" set CH_WINDOW_DIR=%CH_WINDOW_DIR:~0,-1%
if "%CH_WINDOW_DIR:~-1%" == ":" (
	set CH_WINDOW_DIR=%CH_PATH%
	if "%CH_TITLE%"=="" GOTO :DEFAULT_TITLE
)
if NOT "%CH_TITLE%"=="" GOTO :DONE_WITH_TITLE
for %%I in ("%CH_WINDOW_DIR%") do set CH_TITLE=%%~nxI
if NOT "%CH_TITLE%"=="" GOTO :DONE_WITH_TITLE

REM Set window title to a boring default value
:DEFAULT_TITLE
REM set CH_TITLE=%ComSpec%
set CH_TITLE=Command Window at %CH_PATH%

:DONE_WITH_TITLE

REM -------------------------------------------------------------------

set CH_CONFIG=%CH_PATH%\CH_Config.bat
if NOT EXIST "%CH_CONFIG%" (
	set CH_CONFIG=%CH_SCRIPT_PATH%\CH_Config.bat
)

if "%CH_OPEN_NEW_WINDOW%"=="1" GOTO :OPEN_NEW_WINDOW

:USE_EXISTING_WINDOW
if EXIST "%CH_CONFIG%" (
	call :CH_ClearVars & CMD /K TITLE %CH_TITLE% ^& cd /D "%CH_WINDOW_DIR%" ^& "%CH_CONFIG%"
) else (
	call :CH_ClearVars & CMD /K TITLE %CH_TITLE% ^& cd /D "%CH_WINDOW_DIR%"
)

GOTO :DONE_WITH_WINDOW

:OPEN_NEW_WINDOW
if EXIST "%CH_CONFIG%" (
	call :CH_ClearVars & start "%CH_TITLE%" /D "%CH_WINDOW_DIR%" CMD /K TITLE %CH_TITLE% ^& "%CH_CONFIG%"
) else (
	call :CH_ClearVars & start "%CH_TITLE%" /D "%CH_WINDOW_DIR%" CMD /K TITLE %CH_TITLE%
)

:DONE_WITH_WINDOW

REM -------------------------------------------------------------------

:EXIT_BAT
ENDLOCAL
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

REM Detect "From Where" called: Either from Explorer or Command (Line Interpreter) ?
:DetectFromWhere
set CH_FROM_COMMAND=
set CH_FROM_EXPLORER=
set "CH_CMD_TOKENS=%CMDCMDLINE%"
set "CH_CMD_TOKENS=%CH_CMD_TOKENS:&=%"
set CH_CMD_TOKEN1=
for /F "tokens=1 delims= " %%a in ("%CH_CMD_TOKENS%") do (
	set CH_CMD_TOKEN1=%%a
)
if /I "%CH_CMD_TOKEN1%" == "%COMSPEC%" (
	REM Launched from Explorer
	set CH_FROM_EXPLORER=1
) else (
	REM Launched from Command
	set CH_FROM_COMMAND=1
)
GOTO :EOF

REM ---------------------------------------------

:CH_ClearVars
REM We want to leave CH_PATH set
REM set CH_PATH=

set CH_OLDPATH=
set CH_SCRIPT_PATH=
set CH_CD=
set CH_USE_CD=
set CH_BAT_PATH=

set CH_CMD_TOKENS=
set CH_CMD_TOKEN1=
set CH_FROM_EXPLORER=
set CH_FROM_COMMAND=

set CH_OPEN_NEW_WINDOW=
set CH_TITLE=
set CH_CONFIG=
set CH_WINDOW_DIR=
GOTO :EOF

REM ---------------------------------------------

:DebugCmdLine
echo.
echo CH_PATH           "%CH_PATH%"
echo CH_OLDPATH        "%CH_OLDPATH%"
echo CH_SCRIPT_PATH    "%CH_SCRIPT_PATH%"
echo CH_CD             "%CH_CD%"
echo CH_USE_CD         "%CH_USE_CD%"
echo.
echo CH_FROM_COMMAND   "%CH_FROM_COMMAND%"
echo CH_FROM_EXPLORER  "%CH_FROM_EXPLORER%"
echo CH_CMD_TOKENS     "%CH_CMD_TOKENS%"
echo CH_CMD_TOKEN1     "%CH_CMD_TOKEN1%"
echo.
PAUSE
GOTO :EOF
