📱 QR Code & Barcode Scanner App (Flutter + pretty_qr_code)
🎯 Roadmap & Feature Priorities

=== 🚀 v0.1.0 – Core Features (Essential) ===
Goal: Launch a working QR scanner & generator.

1. QR Code Scanning
   - Open camera to scan QR codes
   - Detect text/URL/other content
   - Show simple result screen with scanned content

2. QR Code Generation (Basic)
   - Input text/URL → generate QR code with pretty_qr_code
   - Display generated QR visually

3. Result Actions
   - If URL → “Open in Browser”
   - If text → “Copy to Clipboard”

4. Basic History (Local)
   - Save scanned codes locally (shared_preferences)
   - Simple list view for past scans

---

=== 🌟 v0.2.0 – Enhanced Features ===
Goal: Improve usability and user delight.

**Status:** ✅ COMPLETE (Nov 15, 2025) - 100% Done!

✅ ALL FEATURES IMPLEMENTED:
- Camera flash toggle (for low light) - Already in v0.1.0!
- Share generated QR & scan results (share_plus) ✅ Nov 15, 2025
- Save QR to gallery (gal) ✅ Nov 15, 2025
- Scan from gallery images (image_picker) ✅ Nov 15, 2025
- Barcode scanning support (mobile_scanner) ✅ Nov 15, 2025

🎉 v0.2.0 COMPLETE - Ready for production!

📦 FUTURE ENHANCEMENTS (v0.3.x Candidates):
- Enhanced customization options
- Advanced error handling improvements
- Light/Dark theme toggle

📋 BACKLOG:
- Light/Dark theme toggle
- Enhanced error handling (invalid QR / permission denied)
- Minimal animations (page transitions or QR shimmer)

---

=== 💡 v0.3.x – Advanced Features ===
Goal: Add depth, customization, and long-term value.

**Status:** v0.3.3 ✅ COMPLETE (Nov 15, 2025)

✅ v0.3.0 - Content Type Detection (COMPLETE)
- Auto-detect QR content type (URL, Email, Phone, SMS, Wi-Fi, vCard, Geo, Calendar, Text)
- Smart action buttons based on content type
- Detail dialogs for complex types (Wi-Fi, vCard, Calendar)
- Comprehensive pattern matching and parsing
- Type-specific actions (call, email, maps, etc.)

✅ v0.3.1 - Wi-Fi QR Code Generation (COMPLETE)
- Dedicated Wi-Fi QR generator screen
- Support for WPA/WPA2, WEP, and Open networks
- Hidden network option
- Real-time QR preview with glassmorphism UI
- Share & Save functionality

✅ v0.3.2 - Settings & Theme Toggle (COMPLETE)
- Settings screen with glassmorphism design
- Light/Dark/System theme toggle
- Theme persistence with Hive storage
- Full light theme implementation
- Proper dark theme enhancements
- About section with app version

✅ v0.3.3 - Custom QR Appearance (COMPLETE)
- Custom QR colors (foreground/background) with flex_color_picker
- Logo embedding in QR center
- QR shape styles (smooth, rounded, square, circle)
- Preset save functionality with Hive persistence
- Clean modular architecture (dto/providers/widgets/utils/screens)
- Theme-aware glassmorphism UI
- Reusable button builders utility

✅ v1.0.0 - UI Improvements & UX Polish (COMPLETE)
- Staggered entrance animations on Home and Menu screens
- Reusable AnimatedPressable widget for button scale-down tap feedback
- Custom AnimatedPageRoute helper for smooth page slide-and-fade transitions
- History screen pull-to-refresh, empty state animations, and shimmer loader skeletons
- Green checkmark scan success animation with haptic feedback in scanner screens

---

=== ⚙️ v1.1.0 – Batch Scanning & Portability (Planned) ===
Goal: Support fast high-volume scanning and history data portability.

1. Batch Scanning Mode
   - Toggle to stay on camera during multiple scans
   - Smart floating success banner and scan counter
   - Batch completion actions

2. History Export & Import
   - Export history database to JSON or CSV
   - Import/backup restore from file picker
   - Deduplication and merge validation

---

🧩 Tech Stack (Recommended)
- **Flutter 3.35.7**
- **hive_ce_flutter** → Lightweight and blazing fast key-value database written in pure Dart.
- **flutter_secure_storage** → A Flutter plugin to store data in secure storage
- **riverpod** → A Reactive Caching and Data-binding Framework
- **pretty_qr_code** → QR generation
- **mobile_scanner** → QR scanning
- **url_launcher** → open links in browser
- **share_plus** → share generated QR images
