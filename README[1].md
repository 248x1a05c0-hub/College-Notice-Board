# Campus Connect – College Notice Board

A beginner-friendly Android notice board application developed using Flutter and Dart.

## Features
- View college notices
- Read full notice details
- Add notices with form validation
- Filter notices by department
- Search notices
- Delete notices
- Save notices locally using SharedPreferences
- Loading, error and empty states

## Technology
- Flutter and Dart
- Provider (`ChangeNotifier`)
- SharedPreferences
- intl
- Flutter widget tests

## Requirements
- Flutter stable channel (3.35 or newer recommended for the college specification)
- Android Studio / Android SDK
- JDK 17

## Run the project
```bash
flutter pub get
flutter run
```

## Run tests
```bash
flutter analyze
flutter test
```

## Build release APK
```bash
flutter build apk --release
```

APK output:
`build/app/outputs/flutter-apk/app-release.apk`

## Screenshots
Add at least three screenshots of your running application here before submission.

## Team members
Update this section with the actual team member names and their contributions.

| Member | Contribution |
|---|---|
| Member 1 | Home screen and notice details |
| Member 2 | Add notice form and department filter |
| Member 3 | Provider, storage, testing and integration |

## Data storage
Notices are saved locally on the device using SharedPreferences. Data is not synchronized between different devices.

## Notes
Update the institution details in `lib/screens/about_screen.dart` before submission.
