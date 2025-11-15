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

**Status:** In Progress (Nov 15, 2025)

✅ COMPLETE:
- Camera flash toggle (for low light) - Already in v1.0!
- Share generated QR & scan results (share_plus) ✅ Nov 15, 2025
- Save QR to gallery (gal) ✅ Nov 15, 2025

🔄 NEXT PRIORITIES:
1. Scan from gallery images (image_picker) ⭐ RECOMMENDED
2. Barcode scanning support
3. Enhanced customization options

📋 BACKLOG:
- Light/Dark theme toggle
- Enhanced error handling (invalid QR / permission denied)
- Minimal animations (page transitions or QR shimmer)

---

=== 💡 v1.2 – Growth Stage (Stretch Features) ===
Goal: Add depth, customization, and long-term value.

- Detect QR content type (Wi-Fi, vCard, text, URL, etc.)
- Custom QR appearance (colors, embedded logo)
- Cloud backup/sync for scan history
- Multi-language support
- Export/import scan history

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
