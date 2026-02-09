@echo off
setlocal enabledelayedexpansion

REM ====================================
REM Configuration
REM ====================================
set DOCKER_USER=emil2245
set VERSION=4.0.0
set SCRIPT_DIR=%~dp0
set SERVICES_DIR=%SCRIPT_DIR%services

echo ====================================
echo Building and pushing all microservices IN PARALLEL
echo ====================================
echo Docker User: %DOCKER_USER%
echo Version: %VERSION%
echo Services Directory: %SERVICES_DIR%
echo.

REM Login a Docker Hub
docker login
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Docker login failed
    pause
    exit /b 1
)

echo.
echo ====================================
echo Starting parallel builds...
echo ====================================
echo.

REM ====================================
REM Building all services in parallel using START
REM ====================================

REM Authors (Helidon)
start "BUILD-AUTHORS" cmd /c "cd /d "%SERVICES_DIR%\authors" && docker build -t %DOCKER_USER%/app-authors-helidon:%VERSION% -t %DOCKER_USER%/app-authors-helidon:latest . && docker push %DOCKER_USER%/app-authors-helidon:%VERSION% && docker push %DOCKER_USER%/app-authors-helidon:latest && echo [OK] app-authors-helidon completed!"

REM Books (Helidon)
start "BUILD-BOOKS" cmd /c "cd /d "%SERVICES_DIR%\books" && docker build -t %DOCKER_USER%/app-books-helidon:%VERSION% -t %DOCKER_USER%/app-books-helidon:latest . && docker push %DOCKER_USER%/app-books-helidon:%VERSION% && docker push %DOCKER_USER%/app-books-helidon:latest && echo [OK] app-books-helidon completed!"

REM Customers (Micronaut)
start "BUILD-CUSTOMERS" cmd /c "cd /d "%SERVICES_DIR%\customers" && call gradlew.bat dockerBuild && cd build\docker\main && docker build -t %DOCKER_USER%/app-customers-micronaut:%VERSION% -t %DOCKER_USER%/app-customers-micronaut:latest . && docker push %DOCKER_USER%/app-customers-micronaut:%VERSION% && docker push %DOCKER_USER%/app-customers-micronaut:latest && echo [OK] app-customers-micronaut completed!"

REM Recommendations (Micronaut)
start "BUILD-RECOMMENDATIONS" cmd /c "cd /d "%SERVICES_DIR%\recommendations" && call gradlew.bat dockerBuild && cd build\docker\main && docker build -t %DOCKER_USER%/app-recommendations-micronaut:%VERSION% -t %DOCKER_USER%/app-recommendations-micronaut:latest . && docker push %DOCKER_USER%/app-recommendations-micronaut:%VERSION% && docker push %DOCKER_USER%/app-recommendations-micronaut:latest && echo [OK] app-recommendations-micronaut completed!"

REM Frontend (Vaadin)
start "BUILD-FRONTEND" cmd /c "cd /d "%SERVICES_DIR%\front" && docker build -t %DOCKER_USER%/app-web-vaadin:%VERSION% -t %DOCKER_USER%/app-web-vaadin:latest . && docker push %DOCKER_USER%/app-web-vaadin:%VERSION% && docker push %DOCKER_USER%/app-web-vaadin:latest && echo [OK] app-web-vaadin completed!"

echo.
echo ====================================
echo All builds started in parallel!
echo ====================================
echo.
echo Check the individual windows for progress...
echo Close this window when all builds are complete.
echo.

pause