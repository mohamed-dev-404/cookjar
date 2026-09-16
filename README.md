<div align="center">

# 🫙 CookJar

### Shake. Pick. Cook.

*Good Food, Happy Mood.*

![Flutter](https://img.shields.io/badge/Flutter-3.12-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-Auth-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![State Management](https://img.shields.io/badge/State-Bloc%2FCubit-6C4E9C?style=for-the-badge)
![Status](https://img.shields.io/badge/status-in%20development-FF8A00?style=for-the-badge)

</div>

---

## 🍽️ What is CookJar?

Can't decide what to cook? **Shake the jar.**

CookJar turns "what should I eat today?" into a small moment of fun instead of another decision to make. Shake the jar, get a recipe, and start cooking — with full ingredients, step-by-step instructions, and a place to keep the ones you love.

> Simple Recipes. Big Happiness.

## 🎥 Presentation

<!-- 🔗 TODO: add your presentation link here -->
**[▶ Watch the project presentation]([PRESENTATION_LINK_HERE](https://canva.link/a6b7dukfi0r1u88))**

## 🎨 Design System

CookJar's look is warm, playful, and food-first — built around a jar you can actually shake.

<p align="center">
  <img width="1254" height="1254" alt="design-system" src="https://github.com/user-attachments/assets/879bcde1-94b7-47de-b739-1ece066aaece" />
</p>

| Token | Value | Swatch |
|---|---|---|
| Warm Coral | `#FF8A00` | 🟧 |
| Golden Honey | `#FFB800` | 🟨 |
| Fresh Mint | `#2EC4B6` | 🟩 |
| Off-White | `#FAFAFA` | ⬜ |
| Surface White | `#F5F5F5` | ⬜ |

**Typography:** [Poppins](https://fonts.google.com/specimen/Poppins) for headings, [Inter](https://fonts.google.com/specimen/Inter) for body text.

<!--
| Home | Shake the Jar | Recipe Details | Saved |
|---|---|---|---|
| <img src="docs/readme/screenshots/home.png" width="200"> | <img src="docs/readme/screenshots/jar.png" width="200"> | <img src="docs/readme/screenshots/recipe_details.png" width="200"> | <img src="docs/readme/screenshots/saved.png" width="200"> |
-->

## ✨ Features

- 🫙 **Shake the Jar** — shake to get a random recipe suggestion
- 🔐 **Auth** — email/password sign up & login via Firebase
- 👤 **Personalized Profile** — favorite meal, saved recipe count, editable profile
- 🍳 **Recipe Details** — ingredients, step-by-step instructions, time, servings, and calories at a glance
- ❤️ **Save to "My Love"** — build a personal collection of favorite recipes
- 🎨 **Consistent design system** — one warm, cohesive visual language across every screen

## 🛠️ Tech Stack

| Layer | Tools |
|---|---|
| Framework | Flutter, Dart |
| State Management | flutter_bloc (Cubit) |
| Dependency Injection | get_it |
| Routing | go_router |
| Networking | dio |
| Auth | firebase_auth |
| Local Storage | shared_preferences, flutter_secure_storage |
| Config | flutter_dotenv |
| Animations | lottie |

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

## 🚀 Getting Started

```bash
# 1. Clone the repo
git clone <your-repo-url>
cd cookjar

# 2. Install dependencies
flutter pub get

# 3. Add your environment file
# Create a .env file in the project root with:
# BASE_URL=https://dummyjson.com
# FIREBASE_WEB_API_KEY=...
# (see .env.example if available)

# 4. Run the app
flutter run
```

## 👥 Team

<!-- TODO: add your team -->

| Name              |
| ----------------- |
| Nouran Nasser     |
| Yomna Abdelmedeed |
| Mohamed Ibrahim   |
| Aya Eid           |
| Radwa Mahmoud            |


## 📄 License

<!-- TODO: add a license if this project has one -->
This project is for educational purposes.

---

<div align="center">

**Made with 🧡 and a little shaking.**

</div>
