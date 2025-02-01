@echo off
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
REM -------------------------------------------------------------------
REM CMD_Here
REM	Copyright (c) 2025 Adisak Pochanayon (adisak@gmail.com)
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
