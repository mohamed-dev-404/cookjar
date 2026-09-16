<div align="center">

<img src="assets\images\logo.png" width="110" alt="CookJar Logo" />

<img src="assets\images\name.png" width="260" alt="CookJar" />

### Shake the Jar. Get a Recipe. Cook it.

A fun, minimal recipe discovery app built around an interactive **Recipe Jar** — shake it, and let it surprise you with something delicious.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Auth-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![Hive](https://img.shields.io/badge/Hive-Local%20Storage-FFB800)](https://pub.dev/packages/hive)
[![State Management](https://img.shields.io/badge/State%20Management-Cubit-3EC486)](https://bloclibrary.dev)

</div>

---

## 📖 Overview

**CookJar** turns recipe discovery into a small daily ritual. Instead of scrolling endlessly through a recipe feed, users tap **Shake the Jar** and get a random recipe pulled straight from the jar — with the option to reshake, view full details, or save it to their personal collection for later.

The app is built as a portfolio-grade Flutter project, demonstrating clean architecture, REST API integration, Firebase Authentication, local persistence with Hive, and Cubit-based state management.

```
Shake the Jar → Get a Recipe → View Details → Save it for Later
```

---

## 📱 App Showcase

<div align="center">
<img src="assets\images\CookJar-poster.png" width="850" alt="CookJar App Showcase" />
</div>

---

## ✨ Features

- 🔐 **Firebase Authentication** — email/password sign up, login, and session persistence
- 📝 **Guided Onboarding** — lightweight "Complete Profile" step (photo, display name, favorite meal type)
- 🫙 **Interactive Recipe Jar** — a playful shake animation that surfaces a random recipe from the API
- 🍽️ **Recipe Details** — hero image, ratings, prep/cook time, servings, difficulty, ingredients, and step-by-step instructions
- ❤️ **Favorites ("Love") with Hive** — save recipes locally for offline access
- 👤 **Profile & Stats** — displays loved-recipes count, favorite meal tag, and account actions
- 🎨 **Custom Design System** — a cohesive color palette, icon set, and reusable UI components

---

## 🧠 App Flow

```
Splash Screen
  ├── Authentication
  │     ├── Login
  │     ├── Register
  │     └── Complete Profile
  └── Main App (Bottom Navigation)
        ├── Home            → Shake the Jar → Recipe Preview → Recipe Details
        ├── Love             → Saved Recipes → Shake From Favorites
        └── Profile          → Stats & Account Settings
```

**Home Jar** pulls from all API recipes (online discovery), while the **Love Jar** shakes strictly through your Hive-saved favorites.

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| Language | Dart |
| Authentication | Firebase Authentication |
| Recipe Data | [DummyJSON Recipes API](https://dummyjson.com/recipes) |
| Local Storage | Hive |
| State Management | Cubit |
| Architecture | Clean Architecture (feature-first) |

---


## 🌐 API Reference

CookJar fetches recipe data from the free [DummyJSON Recipes API](https://dummyjson.com/recipes):

```
GET https://dummyjson.com/recipes
```

Each recipe includes ingredients, step-by-step instructions, prep/cook time, servings, difficulty, cuisine, calories, tags, rating, and image — everything needed to power the Recipe Details screen.

---

## 🎨 Design System

| Color | Hex |
|---|---|
| 🟠 Warm Coral | `#FF6B4A` |
| 🟡 Golden Honey | `#FFB800` |
| 🟢 Fresh Mint | `#3EC486` |
| ⚪ Off-White | `#FAFAFA` |
| ⚪ Surface White | `#FFFFFF` |

> See the swatches in the [App Showcase](#-app-showcase) image above for the full visual palette and icon set.

---


## 🏗️ Architecture

Each feature is self-contained and follows a clean, layered structure:

```
lib/
├── app/                 # App-wide setup
├── core/                # Shared: DI, network, routing, theme, widgets
└── features/
    └── <feature_name>/
        ├── data/
        │   ├── data_source/
        │   ├── models/
        │   └── repos/
        └── presentation/
            ├── view/
            │   └── widgets/
            └── view_model/     # Cubit + State
```

Data flows one way: **View → Cubit → Repo → Remote Data Source → API**, with every dependency wired through `get_it` and every screen reacting to a typed, sealed `State`.

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- A configured [Firebase](https://firebase.google.com) project (for Authentication)
- Android Studio / VS Code with the Flutter & Dart plugins

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mohamed-dev-404/cookjar.git
   cd cookjar
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Create a project in the [Firebase Console](https://console.firebase.google.com/)
   - Enable **Email/Password Authentication**
   - Add your Android/iOS app and download `google-services.json` / `GoogleService-Info.plist`
   - Generate `firebase_options.dart` using the FlutterFire CLI:
     ```bash
     flutterfire configure
     ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🧩 Core Screens

| Screen | Description |
|---|---|
| Splash | Checks auth state and routes to Login or Home |
| Login / Register | Firebase-backed authentication flow |
| Complete Profile | Collects display name, photo, and favorite meal type |
| Home | Hosts the interactive jar and "Shake the Jar" flow |
| Recipe Details | Full recipe view with ingredients, instructions, and favorite toggle |
| Love | Saved favorites, backed by Hive|
| Profile | User info, stats, and account actions |


---

<div align="center">
Made with 💛 and Flutter
</div>