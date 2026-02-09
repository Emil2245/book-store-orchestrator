@echo off
setlocal enabledelayedexpansion

REM ====================================
REM Configuration
REM ====================================
set DOCKER_USER=emil2245
set VERSION=1.0.0
set SCRIPT_DIR=%~dp0
set SERVICES_DIR=%SCRIPT_DIR%services

echo ====================================
echo Rebuild and Push Single Service
echo ====================================
echo.
echo Select service to rebuild:
echo   1 - app-authors-helidon
echo   2 - app-books-helidon
echo   3 - app-customers-micronaut
echo   4 - app-recommendations-micronaut
echo   5 - app-web-vaadin
echo.

set /p SERVICE_NUM="Enter service number (1-5): "

if "%SERVICE_NUM%"=="1" (
    set SERVICE_NAME=authors
    set SERVICE_TYPE=helidon
    set SERVICE_FULL=app-authors-helidon
    set SERVICE_DIR=authors
    set BUILD_TYPE=maven
) else if "%SERVICE_NUM%"=="2" (
    set SERVICE_NAME=books
    set SERVICE_TYPE=helidon
    set SERVICE_FULL=app-books-helidon
    set SERVICE_DIR=books
    set BUILD_TYPE=maven
) else if "%SERVICE_NUM%"=="3" (
    set SERVICE_NAME=customers
    set SERVICE_TYPE=micronaut
    set SERVICE_FULL=app-customers-micronaut
    set SERVICE_DIR=customers
    set BUILD_TYPE=gradle
) else if "%SERVICE_NUM%"=="4" (
    set SERVICE_NAME=recommendations
    set SERVICE_TYPE=micronaut
    set SERVICE_FULL=app-recommendations-micronaut
    set SERVICE_DIR=recommendations
    set BUILD_TYPE=gradle
) else if "%SERVICE_NUM%"=="5" (
    set SERVICE_NAME=front
    set SERVICE_TYPE=vaadin
    set SERVICE_FULL=app-web-vaadin
    set SERVICE_DIR=front
    set BUILD_TYPE=docker
) else (
    echo [ERROR] Invalid selection. Please enter a number between 1-5.
    pause
    exit /b 1
)

echo.
echo ====================================
echo Building: %SERVICE_FULL%
echo ====================================
echo Type: %BUILD_TYPE%
echo Directory: %SERVICES_DIR%\%SERVICE_DIR%
echo.

REM Login a Docker Hub
docker login
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Docker login failed
    pause
    exit /b 1
)

REM Navigate to service directory
cd /d "%SERVICES_DIR%\%SERVICE_DIR%"
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Directory not found: %SERVICES_DIR%\%SERVICE_DIR%
    pause
    exit /b 1
)

REM ====================================
REM Build based on type
REM ====================================

if "%BUILD_TYPE%"=="maven" (
    echo Building Helidon service with Docker...
    docker build -t %DOCKER_USER%/%SERVICE_FULL%:%VERSION% -t %DOCKER_USER%/%SERVICE_FULL%:latest .
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Build failed for %SERVICE_FULL%
        pause
        exit /b 1
    )
)

if "%BUILD_TYPE%"=="gradle" (
    echo Building Micronaut service with Gradle...
    call gradlew.bat dockerBuild
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Gradle dockerBuild failed for %SERVICE_FULL%
        pause
        exit /b 1
    )
    
    cd build\docker\main
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Docker directory not found for %SERVICE_FULL%
        pause
        exit /b 1
    )
    
    docker build -t %DOCKER_USER%/%SERVICE_FULL%:%VERSION% -t %DOCKER_USER%/%SERVICE_FULL%:latest .
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Docker build failed for %SERVICE_FULL%
        pause
        exit /b 1
    )
)

if "%BUILD_TYPE%"=="docker" (
    echo Building Vaadin frontend with Docker...
    docker build -t %DOCKER_USER%/%SERVICE_FULL%:%VERSION% -t %DOCKER_USER%/%SERVICE_FULL%:latest .
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Build failed for %SERVICE_FULL%
        pause
        exit /b 1
    )
)

REM ====================================
REM Push to Docker Hub
REM ====================================
echo.
echo Pushing to Docker Hub...

docker push %DOCKER_USER%/%SERVICE_FULL%:%VERSION%
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Push failed for %SERVICE_FULL%:%VERSION%
    pause
    exit /b 1
)

docker push %DOCKER_USER%/%SERVICE_FULL%:latest
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Push failed for %SERVICE_FULL%:latest
    pause
    exit /b 1
)

echo.
echo ====================================
echo SUCCESS!
echo ====================================
echo.
echo %SERVICE_FULL% rebuilt and pushed successfully!
echo.
echo Images available:
echo   - %DOCKER_USER%/%SERVICE_FULL%:%VERSION%
echo   - %DOCKER_USER%/%SERVICE_FULL%:latest
echo.

REM Return to script directory
cd /d "%SCRIPT_DIR%"

pause