@echo off
echo ====================================
echo Building and pushing all microservices
echo ====================================

REM Login a Docker Hub
docker login

echo.
echo ====================================
echo Building app-authors-helidon
echo ====================================
cd authors
docker build -t emil2245/app-authors-helidon:1.0.0 -t emil2245/app-authors-helidon:latest .
docker push emil2245/app-authors-helidon:1.0.0
docker push emil2245/app-authors-helidon:latest
echo [OK] app-authors-helidon pushed!

echo.
echo ====================================
echo Building app-books-helidon
echo ====================================
cd books
docker build -t emil2245/app-books-helidon:1.0.0 -t emil2245/app-books-helidon:latest .
docker push emil2245/app-books-helidon:1.0.0
docker push emil2245/app-books-helidon:latest
echo [OK] app-books-helidon pushed!

echo.
echo ====================================
echo Building app-customers-micronaut
echo ====================================
cd customers\
gradlew.bat dockerBuild
cd build\docker\main\
docker build -t emil2245/app-customers-micronaut:1.0.0 -t emil2245/app-customers-micronaut:latest .
docker push emil2245/app-customers-micronaut:1.0.0
docker push emil2245/app-customers-micronaut:latest
echo [OK] app-customers-micronaut pushed!

echo.
echo ====================================
echo Building app-recommend-micronaut
echo ====================================
cd recommend\
gradlew.bat dockerBuild
cd build\docker\main
docker build -t emil2245/app-recommend-micronaut:1.0.0 -t emil2245/app-recommend-micronaut:latest .
docker push emil2245/app-recommend-micronaut:1.0.0
docker push emil2245/app-recommend-micronaut:latest
echo [OK] app-recommend-micronaut pushed!

echo.
echo ====================================
echo Building app-web-vaadin
echo ====================================
cd front\
docker build -t emil2245/app-web-vaadin:1.0.0 -t emil2245/app-web-vaadin:latest .
docker push emil2245/app-web-vaadin:1.0.0
docker push emil2245/app-web-vaadin:latest
echo [OK] app-web-vaadin pushed!


echo.
echo ====================================
echo All images pushed to Docker Hub!
echo ====================================
echo.
echo Images available:
echo   - emil2245/app-authors-helidon:1.0.0 / latest
echo   - emil2245/app-books-helidon:1.0.0 / latest
echo   - emil2245/app-customers-micronaut:1.0.0 / latest
echo   - emil2245/app-recommend-micronaut:1.0.0 / latest
echo   - emil2245/app-web-vaadin:1.0.0 / latest
echo.
pause