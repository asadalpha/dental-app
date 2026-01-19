# IntelliDent AI - Dental Care App

IntelliDent AI is a modern, premium Flutter application designed for AI-driven dental diagnostics and patient care. The app features a high-fidelity user interface with smooth animations and a consistent design language.

## Features

- **Dynamic Onboarding**: A multi-step animated onboarding experience introducing users to the app's core value propositions.
- **Secure Authentication**: A premium login interface with form validation and simulated authentication logic powered by `Provider`.
- **Integrated Dashboard**:
  - **Dental Tips**: A curated list of oral health tips loaded dynamically from local JSON assets.
  - **Scan History**: Real-time integration with a REST API to fetch and display dental scan history.
  - **Profile Management**: User profile screen with animated settings options and actual logout functionality.
- **Premium UI/UX**:
  - Vibrant deep teal and bright blue color palette.
  - Custom page transitions (Fade, Slide, Scale).
  - Staggered entry animations for all list items using `flutter_animate`.
  - Comprehensive error handling with graceful offline fallbacks and "Retry" mechanisms.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Animations**: [flutter_animate](https://pub.dev/packages/flutter_animate)
- **Networking**: [http](https://pub.dev/packages/http)
- **Aesthetics**: Material 3 with Custom Design System


## Getting Started

### Prerequisites

- Flutter SDK (latest version recommended)
- Android Studio / VS Code with Flutter extension

### Installation

1. Clone the repository:
   ```bash
   git clone git@github.com:asadalpha/dental-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd dental_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Implementation Details

- **API Integration**: The app fetches scan data from JSONPlaceholder. If a network error occurs (e.g., DNS issues), the app automatically switches to an optimized "Offline Mode" showing mock data to ensure a seamless user experience.
- **Theming**: A centralized `AppTheme` manages light/dark-ready tokens, ensuring consistency across buttons, text styles, and cards.
- **Safety**: Includes `mounted` checks for asynchronous navigation and explicit internet permissions for Android.
