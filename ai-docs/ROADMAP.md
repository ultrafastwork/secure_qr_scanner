📱 QR Code & Barcode Scanner App (Flutter + pretty_qr_code)
🎯 MVP Roadmap & Feature Priorities

=== 🚀 v1.0 – Core MVP (Essential) ===
Goal: Launch a working QR scanner & generator with minimal UI.

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

=== 🌟 v1.1 – Polished MVP (Nice-to-Have Enhancements) ===
Goal: Improve usability and user delight.

**Status:** ✅ COMPLETE (Nov 15, 2025) - 100% Done!

✅ ALL FEATURES IMPLEMENTED:
- Camera flash toggle (for low light) - Already in v1.0!
- Share generated QR & scan results (share_plus) ✅ Nov 15, 2025
- Save QR to gallery (gal) ✅ Nov 15, 2025
- Scan from gallery images (image_picker) ✅ Nov 15, 2025
- Barcode scanning support (mobile_scanner) ✅ Nov 15, 2025

🎉 v1.1 COMPLETE - Ready for production!

📦 FUTURE ENHANCEMENTS (v1.2 Candidates):
- Enhanced customization options
- Advanced error handling improvements
- Light/Dark theme toggle

📋 BACKLOG:
- Light/Dark theme toggle
- Enhanced error handling (invalid QR / permission denied)
- Minimal animations (page transitions or QR shimmer)

---

=== 💡 v1.2 – Growth Stage (Smart Features) ===
Goal: Add depth, customization, and long-term value.

**Status:** v1.2.2 ✅ COMPLETE (Nov 15, 2025)

✅ v1.2.0 - Content Type Detection (COMPLETE)
- Auto-detect QR content type (URL, Email, Phone, SMS, Wi-Fi, vCard, Geo, Calendar, Text)
- Smart action buttons based on content type
- Detail dialogs for complex types (Wi-Fi, vCard, Calendar)
- Comprehensive pattern matching and parsing
- Type-specific actions (call, email, maps, etc.)

✅ v1.2.1 - Wi-Fi QR Code Generation (COMPLETE)
- Dedicated Wi-Fi QR generator screen
- Support for WPA/WPA2, WEP, and Open networks
- Hidden network option
- Real-time QR preview with glassmorphism UI
- Share & Save functionality

✅ v1.2.2 - Settings & Theme Toggle (COMPLETE)
- Settings screen with glassmorphism design
- Light/Dark/System theme toggle
- Theme persistence with Hive storage
- Full light theme implementation
- Proper dark theme enhancements
- About section with app version

📋 PLANNED (v1.2.3+):
- Custom QR appearance (colors, embedded logo)
- Export/import scan history
- Haptic feedback settings
- Advanced QR customization
- Batch scanning mode

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
