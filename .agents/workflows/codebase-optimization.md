---
description: Run this right before you run your build system to make sure the AI hasn't skipped code-generation files.
---

Check the entire codebase for missing files, model compilation discrepancies, or outdated imports. 
Run the build_runner terminal command if any immutable data models are missing their generated `.freezed.dart` or `.g.dart` sister components. Fix any invalid Riverpod annotations immediately.
