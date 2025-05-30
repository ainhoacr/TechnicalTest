# 🧬 Rick and Morty App

Una aplicación SwiftUI construida con arquitectura **Clean**, principios **SOLID** y separación por capas. Consulta y visualiza personajes de la serie [Rick and Morty](https://rickandmortyapi.com/).


## 📦 Apliacación

| Módulo            | Descripción                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| `APIClient`       | Swift Package que encapsula red, endpoints, DTOs, errores y repositorios.   |
| `TechnicalTest`   | Capa de presentación: vistas SwiftUI, view models, navegación y contenedor de dependencias. |

---

## 🧱 Arquitectura

Se sigue el patrón Clean Architecture con separación clara de responsabilidades:

- SwiftUI Views: interfaz visual (CharacterListView, CharacterCardView, LoadingView)
- ViewModels: lógica de presentación (CharacterListViewModel)
- Coordinación de dependencias: patrón de inversión de control (DependencyContainer)
- Casos de uso: encapsulación de reglas de negocio (GetCharactersUseCase)
- Entrada de la app: punto de arranque de SwiftUI (TechnicalTestApp)
- Recursos: Assets.xcassets, Localizable.strings
- Tests de presentación y dominio: pruebas unitarias de view models y casos de uso

```
TechnicalTest/
├── Domain/
│   └── UseCases/
│       └── GetCharactersUseCase.swift
├── Infrastructure/
│   └── DependencyContainer.swift
├── Presentation/
│   ├── App/
│   │   └── TechnicalTestApp.swift
│   ├── Views/
│   │   ├── Character List/
│   │   │   ├── CharacterListView.swift
│   │   │   └── CharacterListViewModel.swift
│   │   └── Components/
│   │       ├── CharacterCardView.swift
│   │       └── LoadingView.swift
├── Resources/
│   ├── Assets/
│   └── Localizable.strings
```

## 🚀 Cómo correr la app

1. Clona el repositorio
2. Abre el proyecto con Xcode 16.4
3. Asegúrate de que el destino mínimo es iOS 17
4. Corre el target `TechnicalTest`

## 🧪 Tests

- Implementados con **Swift Testing**

## 📦 Estructura de Módulos

### 🧱 `APIClient` (Swift Package)

- Lógica de red (`APIClient`)
- Endpoints (`CharacterEndpoints`)
- DTOs + parsing (`CharacterDTO`, `CharacterListResponseDTO`)
- Repositorios (`CharacterRepositoryImpl`)
- Modelos de dominio (`Character`)
- Errores, utilidades (`APIError`, `Empty`, `HTTP`, etc.)

```
APIClient/
├── Data/
│   ├── DTOs/
│   └── Repositories/
├── Domain/
│   └── Model/
├── Endpoints/
├── Util/
└── APIClient.swift
```

## 👤 Autor

Ainhoa Calviño Rodríguez