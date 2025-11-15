# 🤖 New Agent Onboarding Prompt

This file contains the recommended prompt to give new AI agents when continuing work on this project.

---

## 📋 CURRENT PROMPT - v1.2.1 (Copy & Paste)

```
I'm continuing work on a Flutter QR Scanner app. v1.2.0 is complete and ready for v1.2.1.

**PROJECT CONTEXT:**
- Location: d:\flutter\secure_qr_scanner
- Status: v1.0 ✅ | v1.1 ✅ | v1.2.0 ✅ | Ready for v1.2.1
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

**YOUR TASK:**
Please read ai-docs/PROGRESS_HANDOFF.md, then implement:

**v1.2.1 - Wi-Fi QR Code Generation** (RECOMMENDED NEXT)

Create a Wi-Fi QR generator screen with:
- Input fields: SSID, Password, Security Type (WPA/WEP/None), Hidden toggle
- Generate format: WIFI:T:WPA;S:NetworkName;P:password;;
- QR code preview
- Share & Save functionality (already exists, reuse it)
- Follow existing glassmorphism design patterns

Implementation guide and format specs are in PROGRESS_HANDOFF.md.
Estimated time: 1.5-2 hours.

**REQUIREMENTS:**
- Must maintain 0 analyzer issues ✅
- Follow feature-based directory structure (qr_code/screens/)
- Use existing generator patterns as reference
- Test with different security types
- Update docs after completion
- Commit with: "feat: Add Wi-Fi QR generation (v1.2.1)"
```

---

## 🔄 How to Use This File

1. **Starting new work?** Copy the "CURRENT PROMPT" section above
2. **After completion**: Update this file with new status and next task
3. **Archive old prompts**: Move to version history section below

---

## 📝 Version History

### v1.2.0 → v1.2.1 (Nov 15, 2025)
**Status**: Current - Ready for Wi-Fi QR Generation
**Focus**: Complete Wi-Fi workflow (detection ✅ + generation)

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

**Last Updated**: Nov 15, 2025  
**Current Version**: v1.2.0 Complete  
**Next Version**: v1.2.1 - Wi-Fi QR Generation
