# Dental AI App - IntelliDent AI

A modern Flutter application designed for dental diagnostics and health monitoring, leveraging AI for smart analysis.

## Implementation Choices

### 1. Architecture: Feature-First (Clean Layout)

The project follows a **feature-based architecture**, which ensures high maintainability and scalability.

- **core/**: Contains global constants, themes, and utility functions used across the app.
- **features/**: Each feature (Auth, Dashboard, History, Onboarding) has its own folder containing its logic (providers), models, and UI (screens/widgets).
- **shared/**: Houses reusable UI components used by multiple features.

### 2. State Management: Provider

We chose **Provider** for state management because of its simplicity and efficiency in the Flutter ecosystem.

- **Global Accessible State**: Using `MultiProvider` in the root (`main.dart`) allows us to provide application-wide state like `AuthProvider` and `ChecklistProvider`.
- **Reactivity**: It leverages `ChangeNotifier` to notify listeners only when necessary, keeping the UI in sync with the business logic.
- **Decoupling**: It helps separate the UI from the underlying business logic, making the code easier to test and maintain.

### 3. Networking: Dio

For API interactions, we utilize **Dio** instead of the standard `http` package for several technical advantages:

- **Interceptors**: Easily add global loggers, authentication headers, or error handling.
- **Global Configuration**: Set base URLs, timeouts, and headers once in `BaseOptions`.
- **Advanced Features**: Built-in support for FormData, file uploads, and request cancellation.
- **Superior Error Handling**: Provides detailed `DioException` objects that make debugging network issues much simpler.

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: Provider
- **Networking**: Dio
- **Animations**: Flutter Animate
- **API**: DummyJSON (for demo data/history)



## 🏁 Getting Started

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to launch the app.
