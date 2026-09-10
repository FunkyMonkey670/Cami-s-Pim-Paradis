@echo off
setlocal
pushd "%~dp0.." >nul
node ".\tools\cl-bundler.mjs" %*
set "BUNDLER_EXIT_CODE=%ERRORLEVEL%"
popd >nul
exit /b %BUNDLER_EXIT_CODE%
