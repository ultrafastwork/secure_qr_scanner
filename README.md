# 📱 Secure QR Scanner

A free and open source QR code scanner and generator built with Flutter. Your data stays private with local-only storage, wrapped in a clean, modern interface.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Status](https://img.shields.io/badge/Status-v0.1.0%20Complete-success)

---

## ✨ Features

- 🔍 **QR Code Scanner** - Scan QR codes using device camera
- 🎨 **QR Code Generator** - Generate beautiful QR codes from text/URLs
- 📜 **Scan History** - Local storage with Hive (CRUD operations)
- 🌌 **Clean UI** - Modern design with light and dark themes
- 🎯 **Smart Actions** - Open URLs, copy text, save to history
- ⚡ **Fast & Lightweight** - Optimized performance with Riverpod

---

## 🚀 Quick Start

### Prerequisites
- Flutter 3.x or higher
- Dart 3.x or higher

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd secure_qr_scanner

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Testing

```bash
# Run all tests
flutter test

# Run code analysis
flutter analyze
```

---

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point (42 lines)
├── app/
│   ├── screens/home_screen.dart   # Main home screen
│   └── theme/app_theme.dart       # App theme configuration
├── qr_code/
│   └── screens/
│       ├── scanner_screen.dart    # QR scanning with camera
│       ├── generator_screen.dart  # QR code generation
│       └── result_screen.dart     # Scan result display
├── history/
│   ├── dto/                       # Data models
│   ├── providers/                 # Riverpod providers
│   ├── services/                  # Business logic
│   └── screens/                   # History UI
└── barcode/                       # Ready for v0.2.0 expansion
```

---

## 🛠️ Tech Stack

| Package | Purpose |
|---------|---------|
| `mobile_scanner` | QR code scanning |
| `pretty_qr_code` | QR code generation |
| `hive_ce` & `hive_ce_flutter` | Local storage |
| `flutter_riverpod` | State management |
| `url_launcher` | Open URLs in browser |
| `google_fonts` | Typography (Inter) |

---

## 📚 Documentation

### For Users
- **Quick Overview** - This README
- **Feature Roadmap** - See `ai-docs/ROADMAP.md`
- **Design Guidelines** - See `ai-docs/DESIGN.md`

### For Developers/AI Agents
- **Current Progress** - `ai-docs/PROGRESS_HANDOFF.md` (start here!)
- **v0.1.0 Implementation** - `ai-docs/PROGRESS_HANDOFF_v0.1.0_COMPLETE.md`
- **Archived Planning** - `ai-docs/IMPLEMENTATION_PLAN_v0.1.0_ARCHIVE.md`

---

## 🔒 Privacy & Security

- **100% Local** - All data stored on your device using Hive
- **No Tracking** - Zero analytics, no data collection
- **Open Source** - Full transparency, audit the code yourself
- **Offline First** - Works without internet connection

## 🎨 Design System

- **Theme**: Light and dark modes with purple gradient accents
- **Typography**: Google Fonts - Inter
- **Details**: See `ai-docs/DESIGN.md` for complete specifications

---

## 🗺️ Roadmap

### ✅ v0.1.0 - Core Features (Complete)
- QR scanner & generator
- Local history with Hive
- Modern UI with theming

### ✅ v0.2.0 - Enhancements (Complete)
- Share functionality
- Save QR to gallery
- Barcode scanner support
- Gallery image scanning
- Camera flash improvements

### ✅ v0.3.x - Advanced Features (Complete)
- Content type detection
- Wi-Fi QR generation
- Settings & theme toggle
- Custom QR appearance

### 🔜 v1.0.0+ - Future Features
- UI improvements & animations
- Multi-language support
- Export/import history (local file backup)

**Full Roadmap**: See `ai-docs/ROADMAP.md`

---

## 🧪 Code Quality

- ✅ **Flutter Analyze**: 0 issues
- ✅ **All Tests Passing**: +2 tests
- ✅ **Code Coverage**: Widget tests included
- ✅ **Best Practices**: Feature-based architecture, Riverpod state management

---

## 📝 Development Workflow

1. Check `ai-docs/PROGRESS_HANDOFF.md` for current status
2. Review `ai-docs/ROADMAP.md` for planned features
3. Follow existing code patterns (see `lib/history/` for examples)
4. Maintain design consistency (see `ai-docs/DESIGN.md`)
5. Run `flutter analyze` and `flutter test` before committing
6. Update `ai-docs/PROGRESS_HANDOFF.md` after completing work

---

## 🤝 Contributing

This project follows a feature-based architecture:
- Each feature has its own directory (e.g., `qr_code/`, `history/`)
- Use Riverpod for state management
- Follow Material 3 design principles
- Maintain design consistency across themes

---

## 📄 License

This project is licensed under the MIT License.

---

## 🔗 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Riverpod Documentation](https://riverpod.dev/)

---

**Status**: v0.3.3 Complete ✅ | **Next**: v1.0.0 Features  
**Last Updated**: Nov 15, 2025
