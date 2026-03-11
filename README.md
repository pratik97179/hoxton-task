# Hoxton Task

Flutter application with intro, authentication, and home flows. Uses a feature-based layout with domain/data/presentation layers, dependency injection, and declarative routing.

## Requirements

- Flutter SDK ^3.11.1
- Dart ^3.11.1

## Setup

```bash
flutter pub get
```

Run on a device or simulator:

```bash
flutter run
```

The app expects a backend at `http://localhost:3000` (iOS simulator) or `http://10.0.2.2:3000` (Android emulator). Configure base URL in `lib/core/di/injection.dart` if needed.

## Project structure

```
lib/
  main.dart                 # App entry, DI init, session restore, router
  core/
    design/                 # Theming, palette, shared widgets
    di/                     # GetIt service locator setup
    network/                # Dio client, interceptors, API envelope
    router/                 # GoRouter config and route names
    session/                # Session persistence (SharedPreferences)
    utils/                  # Password validation, etc.
    extensions/
    logger/
  features/
    auth/                   # Email/password auth, register, login
    home/                   # Dashboard, net worth, assets, liabilities
    intro/                  # Onboarding, splash, pre-boarding
```

Features follow a layered layout:

- **domain**: entities, repository interfaces, use cases
- **data**: remote/data sources, models, repository implementations
- **presentation**: pages, widgets, controllers (Cubit/Bloc-style where used)

## Tech stack

| Area | Choice |
|------|--------|
| Routing | go_router |
| DI | get_it |
| HTTP | Dio |
| State | flutter_bloc (where used) |
| Persistence | shared_preferences (tokens, session) |
| Charts | fl_chart |
| Assets | flutter_svg, custom fonts (Sentient) |

## Flows

1. **Intro** – Initial screen; navigates to email entry when continuing.
2. **Auth** – Email page then password page; supports set (register) and verify (login). On success, goes to pre-boarding or home depending on flow.
3. **Pre-boarding** – Post-auth onboarding; on complete, navigates to home.
4. **Home** – Main screen with net worth, assets/liabilities, news, and bottom nav. Shown as initial route when an access token is present.

Route names and paths are centralized in `lib/core/router/app_route_names.dart`.

## Configuration

- **API base URL**: `lib/core/di/injection.dart` (Dio `BaseOptions.baseUrl`).
- **Linting**: `analysis_options.yaml` (includes `package:flutter_lints/flutter.yaml`).

## Assets

- **Fonts**: Sentient (Light, Regular, Medium, Bold) under `assets/fonts/`.
- **Images**: `assets/images/png/`, `assets/images/svg/`; both are listed in `pubspec.yaml` under `flutter.assets`.


## Building

```bash
flutter build apk    # Android
flutter build ios    # iOS
```
