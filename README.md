# 📸 Instagram Clone — Flutter Frontend

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-brightgreen?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

**A pixel-perfect Instagram-inspired UI built with Flutter**

</div>

---

## 📱 Screenshots

| Login | Feed | Reels | Profile |
|-------|------|-------|---------|
| ![Login](https://via.placeholder.com/200x400/000000/ffffff?text=Login) | ![Feed](https://via.placeholder.com/200x400/000000/ffffff?text=Feed) | ![Reels](https://via.placeholder.com/200x400/000000/ffffff?text=Reels) | ![Profile](https://via.placeholder.com/200x400/000000/ffffff?text=Profile) |

---

## ✨ Features

### 🔐 Authentication
- Login Screen with show/hide password
- Signup Screen with avatar upload
- Smooth fade-in animations on load
- Google login button (UI only)

### 🏠 Feed
- Stories row with gradient rings
- Full screen story viewer with progress bar
- Post cards with double-tap to like ❤️
- Animated like/save buttons
- Pull to refresh
- Staggered card animations

### 💬 Comments
- Bubble-style comment UI
- Nested replies with expand/collapse
- Like individual comments
- Reply to specific users
- Post new comments

### 🔁 Share & Repost
- Repost to feed
- Add to Story
- Save post
- Copy link
- Send to friends

### 🎬 Reels
- Vertical scroll (PageView)
- Like, comment, share actions
- Spinning music disc animation
- Follow button on reels

### 📨 Direct Messages
- Messages + Requests tabs
- Online status indicator 🟢
- Unread message badges
- Individual chat screen
- Send/mic toggle animation
- Bubble chat UI

### 🔍 Search & Explore
- Search bar
- Explore grid (3 column)

### 📤 Upload
- POST / REEL / STORY tabs
- Image preview
- Filter selection (Normal, Clarendon, Gingham, Lark, Reyes)
- Caption input
- Tag People, Add Location options

### 👤 Profile
- Stats (Posts, Followers, Following)
- Story Highlights
- Vertical portrait grid (3:4 ratio)
- Posts / Reels / Tagged tabs
- Edit Profile button
- Settings menu (Archive, QR Code, Saved, Log Out)

### 🎨 UI/UX
- Pure dark theme
- Instagram gradient story rings
- Smooth animations & transitions
- Bottom nav: Home → Reels → DMs → Search → Profile
- Create (+) button top-left (2025 Instagram style)
- Verified badge on profile

---

## 📁 Project Structure

```
instagram_clone/
│
├── pubspec.yaml
│
└── lib/
    ├── main.dart
    │
    ├── utils/
    │   └── colors.dart              ← App colors & gradients
    │
    ├── models/
    │   └── dummy_data.dart          ← Dummy posts, stories, reels
    │
    ├── widgets/
    │   ├── story_widget.dart        ← Stories row
    │   ├── story_viewer.dart        ← Full screen story viewer
    │   ├── post_card.dart           ← Post card with all actions
    │   └── comments_sheet.dart      ← Comments bottom sheet
    │
    └── screens/
        ├── home_screen.dart         ← Bottom nav container
        │
        ├── auth/
        │   ├── login_screen.dart    ← Login UI
        │   └── signup_screen.dart   ← Signup UI
        │
        ├── feed/
        │   └── feed_screen.dart     ← Home feed
        │
        ├── reels/
        │   └── reels_screen.dart    ← Vertical reels
        │
        ├── dm/
        │   └── dm_screen.dart       ← Direct messages + chat
        │
        ├── search/
        │   └── search_screen.dart   ← Explore grid
        │
        ├── upload/
        │   └── upload_screen.dart   ← Post upload + filters
        │
        └── profile/
            └── profile_screen.dart  ← User profile
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / VS Code
- Git

### Installation

**1. Clone the repository**
```bash
git clone https://github.com/syedazfar313/instagram_clone.git
cd instagram_clone
```

**2. Install dependencies**
```bash
flutter pub get
```

**3. Run the app**
```bash
# Chrome (Web)
flutter run -d chrome

# Android
flutter run -d android

# iOS
flutter run -d ios

# Windows
flutter run -d windows
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  cached_network_image: ^3.3.0
  google_fonts: ^6.1.0
```

---

## 🎨 Design System

| Token | Value |
|-------|-------|
| Background | `#000000` |
| Surface | `#111111` |
| Surface 2 | `#1A1A1A` |
| Border | `#262626` |
| Text Primary | `#FFFFFF` |
| Text Secondary | `#A8A8A8` |
| Blue (CTA) | `#0095F6` |
| Red (Like) | `#ED4956` |
| Story Gradient | `#F09433 → #BC1888` |

---

## 🗺️ Roadmap

- [x] Login / Signup UI
- [x] Feed with Stories
- [x] Reels Screen
- [x] Direct Messages
- [x] Upload Screen
- [x] Profile Screen
- [x] Comments with Replies
- [x] Repost / Share Sheet
- [x] Animations & Transitions
- [ ] Firebase Authentication
- [ ] Firestore Database
- [ ] Firebase Storage
- [ ] Push Notifications
- [ ] Real Image Picker
- [ ] Search Functionality
- [ ] Dark / Light Mode Toggle

---

## 🤝 Contributing

Contributions welcome! Feel free to:

1. Fork the project
2. Create your branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

Distributed under the MIT License.

---

## 👨‍💻 Author

**Syeda Zafar**
- GitHub: [@syedazfar313](https://github.com/syedazfar313)

---

<div align="center">

⭐ **Star this repo if you found it helpful!** ⭐

Made with ❤️ using Flutter

</div>
