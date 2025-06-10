# FitApp

A comprehensive Flutter-based fitness application that helps users track workouts, monitor nutrition, and achieve their fitness goals.

## 📱 Features

- **Workout Tracking**: Log exercises with detailed metrics (calories, duration, repetitions)
- **Nutrition Management**: Track meals and monitor caloric intake
- **Progress Analytics**: Visualize fitness progress with charts and statistics
- **Community Features**: Connect with other fitness enthusiasts
- **Personalized Recommendations**: Get workout and meal suggestions
- **Offline Support**: Full functionality even without internet connection

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ^3.5.4
- Dart SDK
- Firebase account
- Supabase account

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/FitApp.git
cd FitApp
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
- Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
- Update Firebase configuration in `lib/firebase_options.dart`

4. Configure Supabase:
- Update Supabase credentials in `lib/main.dart`

5. Run the app:
```bash
flutter run
```

## 📋 Documentation

- [Testing Strategies and Performance Metrics](docs/TESTING_AND_PERFORMANCE.md)
- [Performance Comparison Summary](docs/PERFORMANCE_COMPARISON_SUMMARY.md)
- [Testing Checklist](docs/TESTING_CHECKLIST.md)

## 🏗️ Architecture

FitApp follows clean architecture principles with:
- **Presentation Layer**: UI components and state management (BLoC/Cubit)
- **Domain Layer**: Business logic and entities
- **Data Layer**: Repositories and data sources
- **Core Layer**: Shared utilities and services

## 🛠️ Technology Stack

- **Framework**: Flutter (Dart)
- **State Management**: flutter_bloc (Cubit pattern)
- **Backend**: Firebase (Auth, Firestore) & Supabase (Storage)
- **Navigation**: go_router
- **Dependency Injection**: get_it
- **Local Storage**: shared_preferences

## 🧪 Testing

Run tests with:
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test

# Test coverage
flutter test --coverage
```

See [Testing Documentation](docs/TESTING_AND_PERFORMANCE.md) for detailed testing strategies.

## 📊 Performance

FitApp is optimized for performance:
- **App Size**: 45MB (40% smaller than competitors)
- **Launch Time**: 1.8s (28% faster)
- **Memory Usage**: 120MB average (31% less)

See [Performance Comparison](docs/PERFORMANCE_COMPARISON_SUMMARY.md) for detailed metrics.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Team

- Amar Yasser - Lead Developer

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase and Supabase for backend services
- All contributors and testers 
