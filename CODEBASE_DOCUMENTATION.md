# Sizters iOS App - Codebase Documentation

### Technical Stack
- **Flutter SDK**: >=3.1.2 <4.0.0
- **Dart**: 3.1.2+
- **Target Platforms**: iOS (primary), Android

### Key Dependencies
- **State Management**: GetX
- **UI Components**: 
  - `flutter_svg`: For SVG image rendering
  - `carousel_slider`: For image carousels
  - `fl_chart`: For data visualization
  - `google_fonts`: For custom typography
- **Networking**: 
  - `dio`: For HTTP requests
  - `http`: For API communication
- **Local Storage**:
  - `shared_preferences`: For local data persistence
  - `cached_network_image`: For image caching
- **Authentication**:
  - Firebase Authentication
  - `flutter_otp_text_field`: For OTP verification
- **Maps & Location**:
  - `geolocator`: For location services
  - `geocoding`: For address handling
- **Payments**:
  - `flutter_stripe`: For payment processing

## 🧩 2. Folder Structure & Architecture

### Directory Structure
```
lib/
├── AddItemsPages/     # Screens for adding/editing items
├── Controllers/       # Business logic and state management
├── Filters/           # Filtering components and logic
├── HomePages/         # Main app screens
├── LoginSignUp/       # Authentication flows
├── Pages/             # Core app screens
└── Utils/             # Shared utilities and helpers
```

### Architecture
- **Pattern**: MVVM with GetX
- **State Management**: GetX for state and dependency injection
- **Separation of Concerns**:
  - Controllers handle business logic
  - Views are kept as dumb widgets
  - Models for data structures
  - Services for API and external integrations

## 🔄 3. App Flow & Navigation

### Main Navigation Flow
1. **Splash Screen** → Authentication Check → Home/Login
2. **Home** (Tab-based Navigation):
   - Browse Products
   - Search
   - Cart
   - Profile

### Key Routes
- `/`: Splash/Initial Route
- `/login`: Authentication
- `/home`: Main dashboard
- `/product/:id`: Product details
- `/cart`: Shopping cart
- `/checkout`: Payment flow

### Startup Sequence
1. Firebase initialization
2. Authentication state check
3. Deep link handling
4. Main app initialization

## ⚙️ 4. State Management

### GetX Implementation
- **Controllers**: Extend `GetxController`
- **Reactive State**: Using `.obs` observables
- **Dependency Injection**: `Get.put()` and `Get.find()`

### Key Controllers
- `BottomNavController`: Manages bottom navigation
- `CartPromoController`: Handles cart and promotions
- `ChatController`: Manages chat functionality
- `FilterController`: Handles product filtering
- `ProfileController`: Manages user profile

## 🌐 5. API & Backend Integration

### Backend Services
- **Authentication**: Firebase Auth
- **API Base**: Custom REST API
- **Realtime Updates**: Firebase Realtime Database

### Service Layer
- API endpoints defined in services
- Error handling and response parsing
- Token management

### Error Handling
- Global error handling
- Network error states
- Retry mechanisms

## 🧱 6. Data Models

### Key Models
- `User`: User profile and authentication data
- `Product`: Product details and metadata
- `CartItem`: Shopping cart items
- `Order`: Purchase history and details

### Serialization
- Manual JSON serialization/deserialization
- Factory constructors for model creation

## 💾 7. Local Storage & Persistence

### Data Storage
- **SharedPreferences**: For user preferences and auth tokens
- **SQLite/Other**: For offline data caching (if implemented)

### Data Sync
- Background sync for offline support
- Conflict resolution strategies

## 🖼️ 8. UI Components & Theming

### Theme
- Custom theme in `main.dart`
- Google Fonts integration
- Consistent color scheme

### Reusable Components
- Custom buttons
- Form fields
- Product cards
- Image galleries

## 🔐 9. Authentication & Security

### Authentication Flow
1. Phone/Email sign-in
2. OTP verification
3. Session management

### Security Measures
- Secure token storage
- HTTPS for all API calls
- Input validation
- Rate limiting

## 🚀 10. Build & Deployment

### Building for iOS
```bash
flutter pub get
flutter build ios --release
open ios/Runner.xcworkspace
```

### Release Process
1. Update version in `pubspec.yaml`
2. Run build command
3. Archive in Xcode
4. Upload to TestFlight/App Store

## 🧠 11. Developer Setup

### Prerequisites
- Flutter SDK (>=3.1.2)
- Xcode (for iOS)
- CocoaPods
- Firebase account

### Setup Steps
1. Clone the repository
2. Run `flutter pub get`
3. Configure Firebase
4. Run `pod install` in `ios/`
5. Run the app with `flutter run`

## 📦 12. Dependencies Summary

### Key Dependencies
- **State Management**: `get: ^4.6.6`
- **UI**: 
  - `flutter_svg: ^2.0.7`
  - `google_fonts: ^5.1.0`
  - `carousel_slider: ^4.2.1`
- **Networking**: 
  - `dio: ^5.3.2`
  - `http: ^1.1.0`
- **Storage**: 
  - `shared_preferences: ^2.2.0`
  - `cached_network_image: ^3.3.1`
- **Maps & Location**:
  - `geolocator: ^10.1.0`
  - `geocoding: ^2.1.1`
- **Payments**:
  - `flutter_stripe: ^11.0.0`


