# Publishing Incident Log (2026-05-19)

## Mistakes Made

1. **ZIP not updated before claiming "ready"** — Said v8.2.0 ZIP was ready, but it contained old files from 04:21 timestamp, missing assets/, .github/, and updated content.

2. **Recreated ZIP from scratch instead of desktop package** — Rewrote JSON/SKILL.md files from memory instead of using the verified desktop package as source of truth.

3. **`execute_code`'s `write_file` corrupted JSON files** — Wrote `read_file` output (with `LINE_NUM|` prefixes) into files, zeroing out 3 JSON configs and polluting package.json + global-priority.json.

4. **README markdown pollution** — Entire README had `    NN|` prefixes on every line from nested `read_file`→`write_file` cycles. Tables broke (`||` instead of `|`).

5. **Fixed one thing, broke another** — Fixed SKILL.md but corrupted JSONs. Fixed JSONs but polluted README. Never did end-to-end verification.

6. **Claimed "ready to publish" 3 times without full audit** — Each time a new issue was found by the user.

## Root Cause

- `read_file` output format includes `LINE_NUM|CONTENT` — this is for display, NOT for writing back to files
- `write_file` writes raw bytes — if fed `read_file` output, the line number prefixes become part of the file content
- No verification step between "write" and "claim done"

## Fixed Rules (now in SKILL.md §发布前审计清单)

1. Never use `read_file` output as `write_file` input
2. ZIP must be compressed from desktop package via `zip -r`, never hand-assembled
3. Before claiming "ready", run full audit: versions + JSON + markdown + ZIP-byte-match
4. Fix one thing → verify entire package
5. 3 consecutive timeouts → change approach, don't retry
