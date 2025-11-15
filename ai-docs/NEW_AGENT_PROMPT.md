# 🤖 New Agent Onboarding Prompt

This file contains the recommended prompt to give new AI agents when continuing work on this project.

---

## 📋 Prompt Template (Copy & Paste)

```
I'm continuing work on a Flutter QR Scanner app. The v1.1 release is 100% complete.

**PROJECT CONTEXT:**
- Location: d:\flutter\secure_qr_scanner
- Status: v1.0 ✅ | v1.1 ✅ | Ready for v1.2 features
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

Let me know which feature you recommend and why!
```

---

## 🔄 How to Use This File

1. **Starting v1.2 work?** Copy the prompt above to a new agent chat
2. **Update after each version**: Modify the "WHAT'S COMPLETE" section as features are done
3. **Customize for specific needs**: Add/remove available features based on priorities

---

## 📝 Version History

- **v1.1 → v1.2** (Nov 15, 2025): Initial prompt created
- Ready for v1.2 feature development

---

## 💡 Tips

- Keep this file updated as versions progress
- The prompt is designed to give agents maximum context in minimum words
- Agents will read PROGRESS_HANDOFF.md for detailed implementation details
- This prompt focuses on high-level direction and feature selection

---

**Last Updated**: Nov 15, 2025
