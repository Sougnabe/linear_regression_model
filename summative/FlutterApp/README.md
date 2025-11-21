# Flutter App Rating Predictor

A Flutter mobile application for predicting mobile app ratings based on app features.

## Features

- User-friendly interface with input validation
- Real-time API integration
- Error handling and loading states
- Material Design UI
- Support for both free and paid apps

## Setup Instructions

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android/iOS emulator or physical device

### Installation

1. Navigate to the FlutterApp directory:
```bash
cd summative/FlutterApp
```

2. Install dependencies:
```bash
flutter pub get
```

3. Update API URL in `lib/main.dart`:
   - Replace `https://your-api-url.com/predict` with your deployed API endpoint
   - For local testing on Android emulator: `http://10.0.2.2:8000/predict`
   - For local testing on iOS simulator: `http://localhost:8000/predict`

### Running the App

1. Start an emulator or connect a physical device

2. Run the app:
```bash
flutter run
```

3. For release build:
```bash
flutter build apk  # For Android
flutter build ios  # For iOS
```

## Input Fields

The app requires the following inputs:

1. **Number of Reviews** (integer, 0 to 100,000,000)
2. **App Size** (float, 0.1 to 500 MB)
3. **Number of Installs** (integer, 0 to 10,000,000,000)
4. **Price** (float, 0.0 to 400.0 USD)
5. **App Type** (dropdown: Free or Paid)
6. **Category** (text: e.g., GAME, SOCIAL, PRODUCTIVITY)

## Testing

To test the app without deploying the API:
1. Run the API locally (see API README)
2. Update the API URL in main.dart
3. Run the Flutter app

## Common Categories

- GAME
- SOCIAL
- PRODUCTIVITY
- ENTERTAINMENT
- TOOLS
- COMMUNICATION
- EDUCATION
- BUSINESS
- LIFESTYLE
- HEALTH_AND_FITNESS

## Troubleshooting

### Network Error
- Ensure the API is running and accessible
- Check the API URL in main.dart
- Verify internet connectivity on device/emulator

### Build Errors
- Run `flutter clean` followed by `flutter pub get`
- Update Flutter SDK: `flutter upgrade`

### Validation Errors
- Ensure all fields are filled
- Check that numeric values are within valid ranges
- Category should not be empty

## License

This project is part of an academic assignment.
