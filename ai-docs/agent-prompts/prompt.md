# 🤖 Agent Onboarding Prompt - v1.1.0

**Current Version**: v1.1.0 (Planning Phase)  
**Last Completed**: v1.0.0 - UI Improvements ✅ (July 11, 2026)  
**Status**: Ready for v1.1.0 development  

---

**PROJECT CONTEXT:**
- Location: d:\flutter\secure_qr_scanner
- Status: v1.0.0 ✅ | Ready for v1.1.0
- **Technical Standards:** See `.windsurfrules` file (read this for all coding standards)
- **Current Status:** See `ai-docs/progress-handoffs/handoff.md`
- **Roadmap:** See `ai-docs/ROADMAP.md`

**YOUR TASK:**
Please read `ai-docs/progress-handoffs/handoff.md`, then implement the v1.1.0 features:

1. **Batch Scanning Mode**
   - Add a "Batch Mode" toggle to the scanner screens.
   - When enabled, scanning a code adds it to the history database reactively and increments a floating badge count, but does not pop the scanner screen.
   - Provide a "Done" action to return from the scanner.

2. **History Export & Import**
   - Export scan history to JSON or CSV and open the share dialog.
   - Import scan history from selected files, merging items and checking for duplicates.

---

**IMPLEMENTATION GUIDE:**
- Review `.windsurfrules` for Riverpod and clean architecture.
- Animations: Use `lib/app/widgets/animated_pressable.dart` and `lib/app/utils/page_transitions.dart`.
- Scanner Screens: `lib/qr_code/screens/scanner_screen.dart` and `lib/barcode/screens/barcode_scanner_screen.dart`.
- History Screen: `lib/history/screens/history_screen.dart`.

**QUALITY CHECKLIST:**
✅ Run `flutter analyze` - Must show 0 issues
✅ Test in both light and dark themes
✅ Verify data import integrity and batch flows
✅ Update documentation after completion
