@echo off
echo.
echo Creating documentation....
echo.

SET WORK=MKDOC_TEMP
mkdir %WORK%
copy MultiMonitorEnv.ahk %WORK%
copy Rectangle.ahk %WORK%

::path to the natural doc folder
SET NDPATH=D:\Portable\PortableApps\AutoHotkey\App\Tools\NaturalDocs\NaturalDocs

pushd %WORK%

::project root path
SET ROOT=%CD%

::documentation folder
SET DOC=_doc

mkdir "%ROOT%\%DOC%\_ndProj" 2>nul
pushd "%NDPATH%"
if exist "%ROOT%\images" SET IMG=-img "%ROOT%\images"

call NaturalDocs.bat -i "%ROOT%" -o HTML "%ROOT%\%DOC%" -p "%ROOT%\%DOC%\_ndProj" %IMG%

popd

if "%1" == "s" (
echo Merging html files ...
mkdocs
rmdir /Q /S _doc
echo Done.
echo.
)

popd

rmdir /S /Q ./%DOC%
mkdir %DOC%
pushd %DOC%
xcopy /E ..\%WORK%\%DOC% .
popd
rmdir /S /Q %WORK%