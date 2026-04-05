# MVVM Architecture Template

A reusable Flutter starter template built with MVVM architecture for scalable and maintainable apps.

## Overview

This template provides a clean project foundation with:

- MVVM-based feature structure
- Cubit (BLoC) for state management
- GetX for navigation, localization, and responsive utilities
- Dio configured with token interceptor support
- Preconfigured splash and main feature flows
- Shared core modules for networking, styling, routes, storage, and utilities

## Project Structure

```text
lib/
  core/
    api/
    configs/
    constants/
    errors/
    interceptors/
    routes/
    storage/
    styles/
    translations/
    widgets/
  features/
    splash_feature/
    main_feature/
  theme/
  main.dart
```

## Getting Started

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd MVVM-Architecture-Template
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
flutter run
```

## Build Commands

```bash
flutter build apk
flutter build ios
flutter build web
```

## Requirements

- Flutter SDK (stable channel recommended)
- Dart SDK (included with Flutter)

## Notes

- Update localization files under `lib/core/translations/`.
- Configure API base URLs and environment values in `lib/core/configs/`.
- Extend features by following the existing MVVM pattern inside `lib/features/`.

## Contributing

Contributions and improvements are welcome.

1. Create a feature branch.
2. Commit your changes.
3. Open a pull request.

## License

This project can be used as a template for personal and commercial Flutter projects.
