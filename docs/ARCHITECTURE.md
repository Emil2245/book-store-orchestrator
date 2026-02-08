\# Arquitectura del Sistema



\## Diagrama de Componentes

```

┌─────────────────────────────────────────────────┐

│           Book Store System                      │

├─────────────────────────────────────────────────┤

│                                                  │

│  ┌──────────────┐      ┌──────────────┐        │

│  │   Authors    │      │    Books     │        │

│  │   Service    │◄────►│   Service    │        │

│  │  (Helidon)   │      │  (Helidon)   │        │

│  └──────────────┘      └──────────────┘        │

│         ▲                      ▲                 │

│         │                      │                 │

│         ▼                      ▼                 │

│  ┌──────────────┐      ┌──────────────┐        │

│  │  Customers   │      │Recommendations│       │

│  │   Service    │◄────►│   Service    │        │

│  │ (Micronaut)  │      │ (Micronaut)  │        │

│  └──────────────┘      └──────────────┘        │

│                                                  │

└─────────────────────────────────────────────────┘

```



\## Servicios



\### Authors Service (Puerto 8081)

\- Framework: Helidon

\- Responsabilidad: CRUD de autores

\- Base de datos: \[Especificar]



\### Books Service (Puerto 8082)

\- Framework: Helidon

\- Responsabilidad: CRUD de libros, relación con autores

\- Base de datos: \[Especificar]



\### Customers Service (Puerto 8083)

\- Framework: Micronaut

\- Responsabilidad: CRUD de clientes

\- Base de datos: \[Especificar]



\### Recommendations Service (Puerto 8084)

\- Framework: Micronaut

\- Responsabilidad: Sistema de recomendaciones basado en historial

\- Base de datos: \[Especificar]



\## Comunicación entre Servicios



\- Protocolo: REST/HTTP

\- Formato: JSON

\- Patrones: \[Sync/Async, Circuit Breaker, etc.]

