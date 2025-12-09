# My Study Mate - Flutter App Setup Guide

## Prerequisites

1. **Install Flutter SDK**
   - Download from: https://flutter.dev/docs/get-started/install/windows
   - Extract to: `C:\flutter`
   - Add to PATH: `C:\flutter\bin`

2. **Install Android Studio**
   - Download from: https://developer.android.com/studio
   - Install Android SDK and emulator

3. **Install VS Code** (Optional but recommended)
   - Install Flutter extension
   - Install Dart extension

## Create Flutter Project

```bash
flutter create my_study_mate
cd my_study_mate
```

## Project Structure

```
my_study_mate/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── onboarding_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── home_screen.dart
│   │   ├── course_selection_screen.dart
│   │   ├── notes_screen.dart
│   │   ├── books_screen.dart
│   │   ├── tests_screen.dart
│   │   ├── profile_screen.dart
│   ├── widgets/
│   │   ├── custom_button.dart
│   │   ├── course_card.dart
│   │   ├── feature_card.dart
│   ├── models/
│   │   ├── user.dart
│   │   ├── course.dart
│   │   ├── note.dart
│   │   ├── test.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── api_service.dart
│   │   ├── storage_service.dart
│   ├── utils/
│   │   ├── constants.dart
│   │   ├── colors.dart
│   │   ├── routes.dart
├── assets/
│   ├── images/
│   ├── icons/
├── pubspec.yaml
```

## Key Dependencies (Add to pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # UI & Navigation
  cupertino_icons: ^1.0.2
  google_fonts: ^6.1.0
  
  # State Management
  provider: ^6.1.1
  
  # HTTP & API
  http: ^1.1.0
  dio: ^5.4.0
  
  # Local Storage
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # PDF Viewer (Secure)
  flutter_pdfview: ^1.3.2
  
  # Authentication
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  
  # Payment Integration
  razorpay_flutter: ^1.3.6
  
  # Security
  flutter_secure_storage: ^9.0.0
  screenshot_callback: ^3.0.0
  
  # Other
  intl: ^0.18.1
  cached_network_image: ^3.3.1
```

## Run Commands

```bash
# Get dependencies
flutter pub get

# Run on Android
flutter run

# Run on iOS
flutter run -d ios

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

## Next Steps

1. Install Flutter SDK
2. Run `flutter doctor` to check setup
3. Create the project using the files I'll provide
4. Test on emulator/device
