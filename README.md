# BiteBuddy – Restaurant Finder App 🍽️

BiteBuddy is a fully functional mobile application built using **Flutter** and **Dart**. It allows users to discover nearby restaurants using the **Google Places API**, view them on a **Google Map**, bookmark favorite locations using **SQLite**, and manage custom restaurant entries. The app supports both light and dark themes and includes responsive navigation across multiple screens.

---

## ✨ Features

- Splash screen with app logo
- Home navigation screen with links to all major features
- Nearby Restaurants List (fetched from Google Places API)
- Detail screen with option to edit/add custom restaurants
- Google Map integration to show nearby restaurant pins
- Bookmarks system using **SQLite** for persistent storage
- Theme toggle (light/dark mode) using **Provider**
- Responsive UI with ListTiles, Cards, Buttons, Icons, etc.

---

## 🧰 Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **Backend**: Google Places API (REST/JSON)
- **Database**: SQLite (`sqflite` & `sqflite_common_ffi`)
- **Maps**: Google Maps Flutter plugin
- **State Management**: Provider
- **Packages Used**:
  - `http`
  - `provider`
  - `google_maps_flutter`
  - `geolocator`
  - `sqflite`
  - `sqflite_common_ffi`
  - `flutter_rating_bar`
  - `intl`
  - `cached_network_image`
  - `url_launcher`

---

## 🛠️ Project Structure

```
lib/
│
├── models/                 # Restaurant model
├── screens/                # All main screens (home, map, list, detail, bookmarks)
├── services/               # API and DB service layers
├── widgets/                # Custom reusable widgets
├── providers/              # ThemeProvider
└── main.dart               # App entry point and routing
```

---

## 🗂️ Screens Implemented

- Splash Screen
- Home Screen (with navigation cards)
- Nearby Restaurants List
- Restaurant Detail & Edit Screen
- Add Restaurant Screen
- Bookmark Screen (SQLite)
- Map Screen (Google Maps)

---

## 💾 How to Run the App

1. Install Flutter SDK: https://flutter.dev/docs/get-started/install
2. Install Android Studio (includes Android SDK & Emulator)
3. Accept Android Licenses:
   ```bash
   flutter doctor --android-licenses
   ```
4. Launch emulator or connect Android phone with USB debugging
5. Clone this repo and run:
   ```bash
   flutter pub get
   flutter run
   ```

---

## 🔑 How API Keys Are Used

This app integrates the **Google Places API** and **Google Maps** using a valid API key.  
The API key is stored securely in the `api_service.dart` file like this:

```dart
static const String _apiKey = 'YOUR_GOOGLE_API_KEY';
```



## 📸 Mockups & Prototypes

Low-fidelity mockups were created using **Figma**, showcasing all major screens. These were used to guide UI layout and user flow during development.

---
