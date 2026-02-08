\# Book Store Microservices System



Sistema de microservicios para gestión de librería con arquitectura distribuida.



\## 📋 Arquitectura



Este proyecto está compuesto por 4 microservicios independientes:



\- \*\*Authors Service\*\* (Helidon) - Puerto 8081 - Gestión de autores

\- \*\*Books Service\*\* (Helidon) - Puerto 8082 - Gestión de libros  

\- \*\*Customers Service\*\* (Micronaut) - Puerto 8083 - Gestión de clientes

\- \*\*Recommendations Service\*\* (Micronaut) - Puerto 8084 - Sistema de recomendaciones



\## 🚀 Inicio Rápido



\### Clonar el proyecto con todos los microservicios:

```bash

git clone --recurse-submodules https://github.com/tuusuario/book-store-orchestrator.git

cd book-store-orchestrator

```



Si ya clonaste sin `--recurse-submodules`:

```bash

git submodule update --init --recursive

```



\### Iniciar todos los servicios con Docker:

```bash

docker-compose up

```



\### Iniciar servicios individualmente:

```bash

\# Authors Service

cd services/authors

./mvnw mn:run



\# Books Service  

cd services/books

./mvnw mn:run



\# Customers Service

cd services/customers

./gradlew run



\# Recommendations Service

cd services/recommendations

./gradlew run

```



\## 📁 Estructura del Proyecto

```

book-store-orchestrator/

├── services/                   # Microservicios (submodules)

│   ├── authors/               # app-authors-helidon

│   ├── books/                 # app-books-helidon

│   ├── customers/             # app-customers-micronaut

│   └── recommendations/       # app-recommend-micronaut

├── infrastructure/            # Configuración de infraestructura

│   └── docker-compose.yml

├── docs/                      # Documentación

├── scripts/                   # Scripts de automatización

└── README.md

```



\## 🔗 Repositorios de Microservicios



\- \[Authors Service](https://github.com/tuusuario/app-authors-helidon)

\- \[Books Service](https://github.com/tuusuario/app-books-helidon)

\- \[Customers Service](https://github.com/tuusuario/app-customers-micronaut)

\- \[Recommendations Service](https://github.com/tuusuario/app-recommend-micronaut)



\## 🛠️ Tecnologías



\- \*\*Helidon\*\* - Framework para Authors y Books services

\- \*\*Micronaut\*\* - Framework para Customers y Recommendations services

\- \*\*Docker\*\* - Containerización

\- \*\*Docker Compose\*\* - Orquestación local



\## 📝 Comandos Útiles

```bash

\# Actualizar todos los submodules a su última versión

git submodule update --remote --merge



\# Ver estado de los submodules

git submodule status



\# Construir todos los servicios

docker-compose build



\# Ver logs de todos los servicios

docker-compose logs -f



\# Detener todos los servicios

docker-compose down

```



\## 👥 Contribución



Para contribuir a un microservicio específico, trabaja directamente en su repositorio correspondiente.

