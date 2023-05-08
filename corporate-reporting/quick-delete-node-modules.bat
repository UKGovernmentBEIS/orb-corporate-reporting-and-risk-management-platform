@ECHO OFF
ECHO Delete node_modules
PAUSE
DEL /F/Q/S node_modules > NUL
RMDIR /Q/S node_modules
EXIT
