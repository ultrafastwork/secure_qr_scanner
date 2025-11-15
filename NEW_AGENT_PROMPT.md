# 🤖 New Agent Chat Prompt

Copy and paste this prompt when starting a new agent session to continue development:

---

## Prompt Template

```
I'm continuing work on a Flutter QR Scanner app. The v1.0 MVP is 100% complete.

**PROJECT CONTEXT:**
- Location: d:\flutter\secure_qr_scanner
- Status: v1.0 Complete ✅ | Ready for v1.1 features
- Main docs: ai-docs/PROGRESS_HANDOFF.md (read this first!)

**WHAT'S COMPLETE (v1.0):**
✅ Modern home screen with glassmorphism design
✅ QR Scanner with camera (mobile_scanner)
✅ QR Generator (pretty_qr_code)
✅ History feature with Hive storage (CRUD)
✅ All navigation connected
✅ Save to history functionality
✅ Code quality: 0 analyzer issues, all tests passing

**DOCUMENTATION STRUCTURE:**
- ai-docs/PROGRESS_HANDOFF.md - Current status & v1.1 roadmap
- ai-docs/PROGRESS_HANDOFF_v1.0_COMPLETE.md - Complete v1.0 details
- ai-docs/ROADMAP.md - Feature roadmap (v1.1, v1.2+)
- ai-docs/DESIGN.md - Design system guidelines
- README.md - Project overview

**YOUR TASK:**
[Choose one:]

Option 1: "Please read ai-docs/PROGRESS_HANDOFF.md and help me implement [specific v1.1 feature from roadmap]"

Option 2: "Please read ai-docs/PROGRESS_HANDOFF.md and suggest which v1.1 feature to implement first"

Option 3: "Please read ai-docs/PROGRESS_HANDOFF.md and [your specific request]"

**IMPORTANT:**
- Follow existing code patterns (see lib/history/ for reference)
- Maintain glassmorphism design consistency
- Use Riverpod for state management
- Run flutter analyze (should show 0 issues)
- Update ai-docs/PROGRESS_HANDOFF.md when done
```

---

## Example Usage

### Example 1: Implementing Share Functionality
```
I'm continuing work on a Flutter QR Scanner app. The v1.0 MVP is 100% complete.

**PROJECT CONTEXT:**
- Location: d:\flutter\secure_qr_scanner
- Status: v1.0 Complete ✅ | Ready for v1.1 features
- Main docs: ai-docs/PROGRESS_HANDOFF.md

**YOUR TASK:**
Please read ai-docs/PROGRESS_HANDOFF.md and help me implement the Share Functionality feature (v1.1). I want to add the ability to share generated QR codes and scan results using the share_plus package.
```

### Example 2: General Continuation
```
I'm continuing work on a Flutter QR Scanner app. The v1.0 MVP is 100% complete.

**PROJECT CONTEXT:**
- Location: d:\flutter\secure_qr_scanner
- Status: v1.0 Complete ✅ | Ready for v1.1 features

**YOUR TASK:**
Please read ai-docs/PROGRESS_HANDOFF.md and suggest which v1.1 feature we should implement first based on user value and implementation complexity.
```

### Example 3: Debugging/Enhancement
```
I'm continuing work on a Flutter QR Scanner app. The v1.0 MVP is 100% complete.

**PROJECT CONTEXT:**
- Location: d:\flutter\secure_qr_scanner
- Status: v1.0 Complete ✅

**YOUR TASK:**
Please read ai-docs/PROGRESS_HANDOFF.md and help me [specific debugging task or enhancement request].
```

---

## Quick Reference for New Agents

**First Steps:**
1. Read `ai-docs/PROGRESS_HANDOFF.md` - Start here!
2. Check `ai-docs/ROADMAP.md` - See what's next
3. Review `ai-docs/DESIGN.md` - Design guidelines
4. Reference `ai-docs/PROGRESS_HANDOFF_v1.0_COMPLETE.md` - Implementation patterns

**Key Commands:**
```bash
flutter run          # Test the app
flutter test         # Run tests (should pass)
flutter analyze      # Check code quality (should be clean)
```

**Code Standards:**
- Feature-based structure: `lib/qr_code/`, `lib/history/`, `lib/barcode/`
- State management: Riverpod
- Design: Glassmorphism with pure black background
- Quality: 0 analyzer issues before committing

---

## Notes

- The project has been fully cleaned up and organized
- All deprecation warnings have been fixed
- Documentation is in `ai-docs/` directory
- README.md is in the root for GitHub visibility
- All tests are passing
- Ready for v1.1 development

**Last Updated**: Nov 15, 2025
