# Flutter Social App

A Flutter social-feed application for creating an account, signing in, viewing a feed of posts, and creating and interacting with posts. The app is backed by an HTTP API and uses local storage for session preferences and cached post data.

> **Project status:** This repository contains the Flutter client. It expects a separate backend API; configure the API host before running it. The current API address in the source is a local-network address and will not work outside that developer's network without configuration.

## Features

Based on the current application code, the project includes:

- Registration, login, and logout through the backend API.
- A “For You” feed that fetches posts from the API.
- UI components and repositories for creating, editing, displaying, and commenting on posts.
- Like, user, and post controllers.
- Local post caching with Hive.
- Light and dark themes.
- Search and navigation screens, plus a notification screen placeholder.
- Image selection and bundled avatar/social-network image assets.

Some screens or actions may require a running, compatible backend and may not be fully implemented yet.

## Requirements

- Flutter SDK with Dart SDK `^3.6.2` (as declared in `pubspec.yaml`).
- A compatible backend API. The client currently uses routes such as `/register`, `/login`, and `/logout`, plus post and comment endpoints.
- Android, iOS, web, or Linux tooling for the platform you want to run. Platform-specific setup is documented in the [Flutter installation guide](https://docs.flutter.dev/get-started/install).

## Run locally

1. Install Flutter and verify the setup:

   ```bash
   flutter doctor
   ```

2. Clone the repository and enter the project directory:

   ```bash
   git clone https://github.com/Mustafaamirzada/flutter-social-app.git
   cd flutter-social-app
   ```

3. Configure the API host in `lib/config/constants/config.dart`. Update `remotehost` (or adjust `Config.BaseUrl` and `Config.Basev1Url`) to the address of your backend. For an Android emulator, a host machine's localhost may require the emulator-specific host address; a physical device usually needs a reachable LAN address. Ensure the backend is listening on the configured port and that the device can reach it.

4. Fetch Dart dependencies and start the app on a connected device or simulator:

   ```bash
   flutter pub get
   flutter run
   ```

To run the tests:

```bash
flutter test
```

## Configuration and backend

API URLs are currently defined in `lib/config/constants/config.dart`. The checked-in configuration points to `http://192.168.0.103:8000/api` and `http://192.168.0.103:8000/api/v1`. These are plain HTTP URLs with a private-network host, so change them for your development environment and use an appropriate secure URL for production. Do not commit credentials, private tokens, or production secrets into source control.

The client expects JSON responses from authentication routes. Login and registration responses are expected to contain user data and a token, which the app stores locally using `shared_preferences`. Provide a backend that matches the request and response formats used by the client repositories and services.

## Project structure

```text
.
├── assets/                 # App images and social-network icons
├── android/                # Android host project
├── ios/                    # iOS host project
├── linux/                  # Linux host project
├── web/                    # Web entry point, icons, and manifest
├── lib/
│   ├── auth/                # Authentication routing and login/register choice
│   ├── components/          # Reusable post, comment, button, and input widgets
│   ├── config/constants/    # Backend API URL configuration
│   ├── controllers/         # Post, user, and like logic
│   ├── models/              # Post models and Hive adapter
│   ├── provider/            # Provider-based app state, including authentication
│   ├── repository/          # Post and comment data access
│   ├── screens/             # Feed, authentication, search, navigation, and related screens
│   ├── services/            # Authentication API service
│   ├── theme/               # Light and dark themes
│   ├── utils/               # Shared helpers
│   └── main.dart            # Hive initialization, providers, themes, and app entry point
├── test/                    # Flutter tests
├── pubspec.yaml             # Dart/Flutter dependencies and asset declarations
└── pubspec.lock             # Resolved dependency versions
```

## Main dependencies

The full dependency declarations and version constraints are in `pubspec.yaml`.

| Package | Purpose in this project |
| --- | --- |
| `http` | Sends requests to the backend API. |
| `provider` | Provides app state, including authentication state. |
| `shared_preferences` | Persists authentication and user preference values locally. |
| `hive`, `hive_flutter` | Local database and Flutter integration for cached posts. |
| `image_picker` | Selects images from the device. |
| `cached_network_image` | Displays cached images loaded from network URLs. |
| `internet_connection_checker` | Checks network connectivity. |
| `get` | Navigation and utility APIs available to the app. |
| `readmore` | Expandable/collapsible text display. |
| `ionicons`, `hugeicons` | Icon sets used by the interface. |
| `cupertino_icons` | Cupertino-style icons. |

Development dependencies include `flutter_test` and `flutter_lints`. `build_runner` and `hive_generator` support generating Hive model adapters; `lib/models/post_hive.g.dart` is the generated adapter currently in the project.

## Tests and contributions

The test directory currently contains Flutter widget tests. Run `flutter test` before submitting changes. Keep API configuration environment-specific, and avoid committing generated build output or secrets.

## License

No license is currently specified in this repository. Unless a license is added, reuse and redistribution are not granted by default.
