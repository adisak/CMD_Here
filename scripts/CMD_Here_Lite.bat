@echo off
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
REM -------------------------------------------------------------------

call :PushCD
set CH_USE_CD=1

call CMD_Here_Global.bat

REM -------------------------------------------------------------------
:ExitBatch
ENDLOCAL
GOTO :EOF

:PushCD
pushd %~dp0"
GOTO :EOF
