@echo off
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
REM -------------------------------------------------------------------

REM Move this script somewhere into a global script path or
REM add this directory to the global PATH variable.  Then
REM Set CH_BAT_PATH to point where CMD_Here.bat is located.

set CH_BAT_PATH=%~dp0
REM set CH_BAT_PATH=S:\Developer\BAT_dev\CMD_Here\scripts

call "%CH_BAT_PATH%\CMD_Here.bat"

REM -------------------------------------------------------------------
:ExitBatch
ENDLOCAL
GOTO :EOF
