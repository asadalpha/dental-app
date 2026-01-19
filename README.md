# IntelliDent AI - Dental Care App

IntelliDent AI is a modern, premium Flutter application designed for AI-driven dental diagnostics and patient care. The app features a high-fidelity user interface with smooth animations and a consistent design language.

## ✨ Features

- **Dynamic Onboarding**: A multi-step animated onboarding experience.
- **Secure Authentication**: Premium login interface powered by `Provider`.
- **Daily Dental Checklist**: A state-managed hygiene tracker to help users maintain oral health.
- **Scan History**: Real-time integration with a REST API to fetch and display dental scan history.
- **Premium UI/UX**: Custom page transitions and staggered animations via `flutter_animate`.

## 🧠 State Management: Why Provider?

For this implementation, I chose **Provider** as the primary state management solution for several reasons:

1.  **Simplicity & Readability**: Provider is the officially recommended starting point for state management in Flutter. It offers a clean way to manage state without the boilerplate of Bloc or the complexity of Riverpod for a project of this scale.
2.  **Scalability**: By using `ChangeNotifierProvider` and `MultiProvider`, we can easily scale the application to include more features (like the `ChecklistProvider` and `AuthProvider`) while keeping the code organized.
3.  **Low Friction**: It integrates natively with the Flutter widget tree (`context.watch`, `context.read`), making it very intuitive for developers to bridge logic and UI.
4.  **Performance**: Provider is efficient for managing local and shared application states, such as user sessions and daily checklists, without unnecessary rebuilds.

## 🚀 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Animations**: [flutter_animate](https://pub.dev/packages/flutter_animate)
- **Networking**: [http](https://pub.dev/packages/http)
- **Aesthetics**: Material 3 with Custom Design System

## 📁 Project Structure

```text
lib/
├── core/
│   └── theme/          # AppColors and AppTheme definitions
├── features/
│   ├── auth/           # Login screen and AuthProvider
│   ├── dashboard/      # Checklist, Profile, and Providers
│   ├── dental_tips/    # Tips list logic
│   └── history/        # API integration and Models
└── shared/             # Reusable UI components
```

## 🛠️ Implementation Highlights

- **API Fallback**: If the network is unreachable, the app automatically switches to an "Offline Mode" showing mock dental scans.
- **Custom Page Transitions**: Implemented `FadeRoute`, `SlideUpRoute`, and `ScaleRoute` for a premium feel.
- **Daily Progress Tracking**: The checklist feature uses reactive state to update progress bars and completion percentages in real-time.
