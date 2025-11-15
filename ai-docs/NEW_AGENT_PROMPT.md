# 🤖 New Agent Onboarding Prompt

This file contains the recommended prompt to give new AI agents when continuing work on this project.

---

## 📋 CURRENT PROMPT - v1.2.3 (Copy & Paste)

**NOTE:** For the complete v1.2.3 prompt, see `NEXT_AGENT_PROMPT_v1.2.3.md`

```
I'm continuing work on a Flutter QR Scanner app. v1.2.2 is complete and ready for v1.2.3.

**PROJECT CONTEXT:**
- Location: d:\flutter\secure_qr_scanner
- Status: v1.0 ✅ | v1.1 ✅ | v1.2.0 ✅ | v1.2.1 ✅ | v1.2.2 ✅ | Ready for v1.2.3
- Main docs: ai-docs/PROGRESS_HANDOFF.md (read this first!)

**WHAT'S COMPLETE:**
✅ v1.0 MVP: QR Scanner, Generator, History (all working)
✅ v1.1 Enhancements:
  - Share functionality (share_plus)
  - Save QR to Gallery (gal)
  - Gallery image scanning (image_picker)
  - Barcode scanner with multi-format support
  - Camera flash toggle
  - 0 analyzer issues, production-ready

✅ v1.2.0 - Content Type Detection (Nov 15, 2025):
  - Auto-detect 9 content types: URL, Email, Phone, SMS, Wi-Fi, vCard, Geo, Calendar, Text
  - Smart action buttons based on content type
  - Detail dialogs for Wi-Fi, vCard, Calendar
  - ContentDetectorService with pattern matching
  - ContentActionService for type-specific actions
  - 0 analyzer issues ✅

✅ v1.2.1 - Wi-Fi QR Code Generation (Nov 15, 2025):
  - Dedicated Wi-Fi QR generator screen
  - Input fields: SSID, Password, Security Type, Hidden toggle
  - Standard Wi-Fi QR format
  - Real-time QR preview with glassmorphism
  - Share & Save functionality
  - 0 analyzer issues ✅

✅ v1.2.2 - Settings & Theme Toggle (Nov 15, 2025):
  - Settings screen with glassmorphism design
  - Light/Dark/System theme toggle
  - Theme persistence with Hive storage
  - Full light and dark theme implementation
  - System theme as default (respects OS)
  - About section with app version
  - 0 analyzer issues ✅

**YOUR TASK:**
Please read ai-docs/PROGRESS_HANDOFF.md, then choose one of these v1.2.3 features:

**OPTION 1: Custom QR Appearance** ⭐ (RECOMMENDED)
**OPTION 2: Export/Import History**
**OPTION 3: Haptic Feedback**
**OPTION 4: Batch Scanning Mode**

See NEXT_AGENT_PROMPT_v1.2.3.md for complete details on each option.

**REQUIREMENTS:**
- Must maintain 0 analyzer issues ✅
- Follow feature-based directory structure
- Use Riverpod for state management
- Test in both light and dark themes
- Follow existing glassmorphism patterns

**AFTER FINISHING:**
- Update ai-docs/PROGRESS_HANDOFF.md and ai-docs/ROADMAP.md
- Report remaining token count
- If flutter analyze shows 0 issues, use GitHub MCP to commit and push
- Create NEXT_AGENT_PROMPT_v1.2.4.md for next feature
- Suggest what's next and ask if I want to proceed
```

---

## 🔄 How to Use This File

1. **Starting new work?** Copy the "CURRENT PROMPT" section above
2. **After completion**: Update this file with new status and next task
3. **Archive old prompts**: Move to version history section below

---

## 📝 Version History

### v1.2.2 → v1.2.3 (Nov 15, 2025)
**Status**: Current - Ready for Custom QR Appearance or other features
**Focus**: Enhanced QR generation or data management features

### v1.2.1 → v1.2.2 (Nov 15, 2025)
**Status**: Completed
**Implemented**: Settings & Theme Toggle with Light/Dark/System modes
**Notes**: System theme as default, full theme persistence

### v1.2.0 → v1.2.1 (Nov 15, 2025)
**Status**: Completed
**Implemented**: Wi-Fi QR Code Generation
**Focus**: Complete Wi-Fi workflow (detection ✅ + generation ✅)

### v1.1 → v1.2.0 (Nov 15, 2025)
**Status**: Completed
**Implemented**: Content Type Detection with smart actions
**Prompt**: Suggested feature and implemented content detection

---

## 📋 ARCHIVED PROMPTS

### Prompt for v1.2.0 (USED - COMPLETED)
```
I'm continuing work on a Flutter QR Scanner app. The v1.1 release is 100% complete.

**PROJECT CONTEXT:**
- Location: d:\flutter\secure_qr_scanner
- Status: v1.0 ✅ | v1.1 ✅ | Ready for v1.2 features
- Main docs: ai-docs/PROGRESS_HANDOFF.md (read this first!)

**YOUR TASK:**
Please read ai-docs/PROGRESS_HANDOFF.md and ai-docs/ROADMAP.md, then suggest which v1.2 feature we should implement first based on:
- User value
- Implementation complexity
- Foundation for future features

**AVAILABLE v1.2 FEATURES:**
- Light/Dark theme toggle
- Advanced QR customization (colors, logos)
- Wi-Fi QR code generation
- Content type detection (auto-detect URL, vCard, etc.)
- Batch scanning mode
- Export/import history
```

---

## 💡 Tips for Prompt Maintenance

- Keep "CURRENT PROMPT" section at the top
- Update "WHAT'S COMPLETE" after each version
- Be specific about the next task
- Include estimated time and requirements
- Archive old prompts in version history
- Update after every major version (v1.x.0)

---

**Last Updated**: Nov 15, 2025 (v1.2.2 Complete)  
**Current Version**: v1.2.2 Complete (Settings & Theme Toggle)  
**Next Version**: v1.2.3 - Choose from 4 feature options
