# 📱 Secure QR Scanner

A modern Flutter QR code scanner and generator app with beautiful glassmorphism UI and local history tracking.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Status](https://img.shields.io/badge/Status-v1.0%20Complete-success)

---

## ✨ Features (v1.0 MVP)

- 🔍 **QR Code Scanner** - Scan QR codes using device camera
- 🎨 **QR Code Generator** - Generate beautiful QR codes from text/URLs
- 📜 **Scan History** - Local storage with Hive (CRUD operations)
- 🌌 **Modern UI** - Glassmorphism design with pure black background
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
└── barcode/                       # Ready for v1.1 expansion
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
- **v1.0 Implementation** - `ai-docs/PROGRESS_HANDOFF_v1.0_COMPLETE.md`
- **Archived Planning** - `ai-docs/IMPLEMENTATION_PLAN_v1.0_ARCHIVE.md`

---

## 🎨 Design System

- **Theme**: Pure black (#000000) with purple/violet/fuchsia gradients
- **UI Style**: Glassmorphism (frosted glass effects)
- **Typography**: Google Fonts - Inter
- **Colors**: Violet-600, Fuchsia-600, Purple-700
- **Details**: See `ai-docs/DESIGN.md` for complete specifications

---

## 🗺️ Roadmap

### ✅ v1.0 - MVP (Complete)
- QR scanner & generator
- Local history with Hive
- Modern glassmorphism UI

### 🔜 v1.1 - Enhancements (Planned)
- Share functionality
- Save QR to gallery
- Barcode scanner support
- Gallery image scanning
- Camera flash improvements

### 💡 v1.2+ - Future Features
- Custom QR styling
- Cloud backup
- Multi-language support
- Export/import history

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
- Maintain glassmorphism UI consistency

---

## 📄 License

This project is licensed under the MIT License.

---

## 🔗 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Riverpod Documentation](https://riverpod.dev/)

---

**Status**: v1.0 Complete ✅ | **Next**: v1.1 Features  
**Last Updated**: Nov 15, 2025
