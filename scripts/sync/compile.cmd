@ECHO OFF
REM A few large scripts that don't change often are compiled for optimization.
WHERE /Q luac
IF ERRORLEVEL 1 GOTO missing
CALL :compile actions.lur
IF ERRORLEVEL 1 GOTO :eof
CALL :compile models.lur
GOTO :eof
:compile
ECHO %1
IF EXIST %1 DEL %1
luac -s -o %1 %~n1.lua
IF EXIST %1 EXIT /B 0
PAUSE >NUL
EXIT /B 1
:missing
ECHO missing luac.exe
PAUSE >NUL