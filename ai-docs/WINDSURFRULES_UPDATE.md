# .windsurfrules Update for progress-handoffs Directory

## Changes Needed

Replace these lines in `.windsurfrules`:

### Line 110 - Change:
```
- Check `ai-docs/PROGRESS_HANDOFF.md` for current version status
```

### To:
```
- Check `ai-docs/progress-handoffs/PROGRESS_HANDOFF.md` for current version status
```

---

### Line 118 - Change:
```
3. Update `ai-docs/PROGRESS_HANDOFF.md`:
```

### To:
```
3. Update `ai-docs/progress-handoffs/PROGRESS_HANDOFF.md`:
```

---

## Complete Updated Section (Lines 109-120)

```
### Current Status & Tasks
- Check `ai-docs/progress-handoffs/PROGRESS_HANDOFF.md` for current version status
- Check `ai-docs/ROADMAP.md` for feature priorities and roadmap
- Check `ai-docs/DESIGN.md` for design references
- Check `ai-docs/prompts/` for version-specific agent prompts

### After Completing a Task
1. Run `flutter analyze` - must show 0 issues
2. Test in both light and dark themes
3. Update `ai-docs/progress-handoffs/PROGRESS_HANDOFF.md`:
   - Rename current to `PROGRESS_HANDOFF_vX.X.X_COMPLETE.md`
   - Create new `PROGRESS_HANDOFF.md` for next version
4. Update `ai-docs/ROADMAP.md` - mark version as complete
5. Create `ai-docs/prompts/AGENT_PROMPT_vX.X.X.md` for next agent
6. Commit with descriptive message and push to GitHub
7. Report remaining token count
8. Suggest next feature and ask if user wants to proceed
```

**Note:** Only the paths changed (added `progress-handoffs/` directory), everything else remains the same.
