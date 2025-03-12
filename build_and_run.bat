@echo off
setlocal enabledelayedexpansion

REM Set variables
set "MATHLIB_DIR=MathLibrary"
set "MathLibTest_DIR=MathLibraryTest"

REM Check if .NET SDK is installed
where dotnet >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: .NET SDK is not installed. Please install it and try again.
    exit /b 1
)

REM Build MathLibrary.dll
echo Building MathLibrary...
cd %MATHLIB_DIR% || exit /b 1
dotnet build
cd ..

REM Check if DLL is created successfully
set "DLL_PATH=%MATHLIB_DIR%\bin\Debug\net8.0\MathLibrary.dll"
if not exist "%DLL_PATH%" (
    echo ERROR: MathLibrary.dll not found. Please check for build errors.
    exit /b 1
)
echo MathLibrary.dll built successfully!

REM Check and add reference if needed
cd %MathLibTest_DIR% || exit /b 1
findstr /C:"MathLibrary" MathLibraryTest.csproj >nul
if %errorlevel% neq 0 (
    echo Adding MathLibrary reference...
    dotnet add reference ..\%MATHLIB_DIR%\MathLibrary.csproj
)

REM Run MathLibraryTest
echo Running MathLibraryTest...
dotnet run

endlocal
