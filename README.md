# 🎨 QR Craft Studio Flutter

A premium, modern cross-platform QR Code Generator and Customization Platform built with Flutter and Dart. Designed with a gorgeous, responsive, SaaS-inspired user interface.

---

## 🌟 Overview

**QR Craft Studio** is an all-in-one QR utility designed to help users generate, customize, export, and manage dynamic and static QR codes. From custom color schemes and logo embedding to analytics tracking and elegant templates, the application provides an enterprise-level toolkit for QR-based marketing and utility management.

Designed with **Glassmorphism**, **Sleek Dark Mode**, and **Fluid Micro-animations**, QR Craft Studio is built for performance and responsive layout support across multiple platforms.

---

## ✨ Features

### 🔍 QR Code Generation
Generate highly customizable QR codes for multiple data types:
* 🌐 **URLs & Websites** — Dynamic or static web links.
* 📝 **Plain Text** — Structured notes, keys, or messages.
* 📶 **WiFi Networks** — Instant credentials sharing.
* 📧 **Email & SMS** — Pre-populated subject lines, bodies, or numbers.
* 📞 **Phone & WhatsApp** — Single-tap calling and chat redirection.
* 📇 **vCards** — Complete contact information profiles.
* 📍 **Location Coordinates** — Exact latitude and longitude mapping.
* 📅 **Event Details** — Calendar items with times, dates, and locations.
* 👥 **Social Media Profiles** — Instagram, Twitter/X, LinkedIn, and more.

### 🎨 Advanced QR Customization
Express brand identity with detailed, pixel-perfect design controls:
* 🌈 **Colors & Gradients** — Solid colors or rich linear/radial gradient foregrounds.
* 📐 **Custom Shapes & Corners** — Adjust eye-frame styles, eye-ball types, and dot patterns.
* 🖼️ **Logo Embedding** — Inject custom brand logos in the center of the QR code with auto-padding.
* 🏷️ **Frames & Labels** — Wrap your QR code in beautiful frames with "Scan Me" calls to action.
* 🔳 **Branding Presets** — Apply predefined styles instantly.

### 💾 Flexible Export Options
High-fidelity, production-ready exports:
* 🖼️ **Formats** — PNG, JPG, and scalable SVG vectors.
* ⚡ **High Resolution** — Select custom dimensions for print or web.
* 👻 **Transparent Backgrounds** — Seamless integration on arbitrary backgrounds.
* 📤 **Native Share Sheet** — Send generated QR codes directly to chat apps, email, or cloud storage.

### 👤 User Workspace & History
* 🔒 **Secure Authentication** — Instant cloud sync for saved designs.
* 🗂️ **Projects & Collections** — Categorize, rename, and organize past designs.
* ✏️ **Real-time Editing** — Reload and modify any saved QR project at any time.

### 📊 Analytics & Insights *(Planned)*
* 📈 **Scan Metrics** — Track scan counts per dynamic QR code.
* 📱 **Device Statistics** — View analytics on OS, browser, and device types.
* 🌍 **Geo-Tracking** — Location and country mapping.

---

## 🏛️ Project Architecture

QR Craft Studio is structured following a **Feature-First Clean Architecture** approach to ensure maintainability, scalability, and clean separation of concerns.

```
lib/
├── core/                   # Shared framework-level resources
│   ├── constants/          # App constants, assets, colors, and layout tokens
│   ├── theme/              # Typography, dark/light themes, and UI values
│   ├── utils/              # Generic utility and helper functions
│   └── services/           # Backend clients (Supabase, shared preferences)
│
├── features/               # Domain-specific application features
│   ├── auth/               # User registration, login, and profile
│   ├── home/               # Central workspace dashboard
│   ├── qr_generator/       # QR data modeling and standard rendering
│   ├── qr_customizer/      # Visual designer, shapes, gradients, and logo overlays
│   ├── qr_export/          # Screenshot rendering and native file writing
│   ├── templates/          # Prebuilt presets (Restaurant, Business, WiFi)
│   └── analytics/          # Scans tracking charts and details
│
├── models/                 # Global data models
├── shared/                 # Common global business logic helpers
├── widgets/                # Reusable presentation widgets (Buttons, Cards, Inputs)
└── main.dart               # App entrypoint
```

---

## 🛠️ Tech Stack & Dependencies

* **Frontend:** Flutter & Dart
* **State Management:** Provider / ChangeNotifier / InheritedWidget
* **Backend:** Supabase Flutter client
* **QR Layout & Code Rendering:** `pretty_qr_code`, `qr_flutter`
* **File Export & Capture:** `screenshot`, `file_saver`, `image_picker`
* **Aesthetics & Motion:** `flutter_animate`, `google_fonts`

> [!NOTE]
> This project has been migrated away from Riverpod. All application states are managed using lightweight standard **Provider** and **ChangeNotifier** mechanisms for robust performance and ease of debugging.

---

## 🚀 Installation & Setup

### Prerequisites
Ensure you have the following installed:
* [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.10.0+ recommended)
* [Dart SDK](https://dart.dev/get-started)
* Git

### Step-by-Step Guide

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/qr-craft-studio-flutter.git
   cd qr-craft-studio-flutter
   ```

2. **Check Flutter Environment:**
   ```bash
   flutter doctor
   ```

3. **Install Core Dependencies:**
   ```bash
   flutter pub get
   ```

4. **Add Recommended Packages to `pubspec.yaml`:**
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     provider: ^6.1.2
     pretty_qr_code: ^3.0.0
     qr_flutter: ^4.1.0
     screenshot: ^3.0.0
     file_saver: ^0.2.0
     image_picker: ^1.1.2
     flutter_animate: ^4.5.0
     google_fonts: ^6.2.1
     supabase_flutter: ^2.6.0
   ```

5. **Run the Application:**
   ```bash
   flutter run
   ```

---

## 🗺️ Development Roadmap

### Phase 1 — Core MVP 🎯
- [x] Initial design system and component creation.
- [x] State management implementation.
- [ ] QR code generator logic (Plain text/URLs).
- [ ] High-resolution PNG and SVG export.
- [ ] Responsive grid layout dashboard.

### Phase 2 — Premium Customizer ✨
- [ ] Shape customization (dots, eye-frames).
- [ ] Logo rendering & layout helper.
- [ ] Linear and radial gradient backgrounds/foregrounds.
- [ ] Interactive prebuilt templates.

### Phase 3 — Workspace & Sync ☁️
- [ ] Supabase authentication & user projects table.
- [ ] Auto-save local draft state.
- [ ] Analytics integration for dynamic URLs.
- [ ] Light & dark mode automatic toggle.