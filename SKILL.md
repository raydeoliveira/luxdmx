---
name: luxdmx
description: >-
  Zero-driver macOS LAN lighting CLI and MCP server for Art-Net 4 (UDP 6454) and
  ANSI E1.31 sACN (UDP 5568) with CIE Planckian/duv color math, Lee/Rosco gel presets,
  multi-universe atomic scenes, pre-write snapshots, and timed/signal auto-revert.
  Use when discovering DMX nodes, testing fixture profiles, setting studio lighting
  safely from terminal or AI agents, or restoring prior lighting states.
---

# Skill: LuxDMX (`luxdmx`)

## Install
```bash
brew install raydeoliveira/tap/luxdmx
# Or inspect capability manifest directly:
luxdmx --describe
```

## Safe LAN Lighting Workflow
1. Always probe nodes and active universes first (read-only):
   ```bash
   luxdmx probe --json
   luxdmx fixtures --json
   luxdmx gels --json
   ```
2. Solve fixture channels or preview slot diffs with zero UDP packets sent:
   ```bash
   luxdmx solve --gel L201 --dim 80 --fixture aputure-600c-rgbww --json
   luxdmx apply --proto sacn --universe 1 --cct 4600 --dim 50 --dry-run --json
   ```
3. Apply safely with automatic pre-write snapshot and 15s auto-revert confirmation (or explicit `--yes` in automated agent calls):
   ```bash
   luxdmx apply --proto sacn --universe 1 --channels 1=255,2=128 --confirm-timeout 15 --json
   # Non-interactive verified write:
   luxdmx apply --proto sacn --universe 1 --channels 1=255,2=128 --yes --json
   ```
4. Replay saved 512-byte DMX snapshots and send E1.31 `Stream_Terminated` (`0x40`) at any time (always Free):
   ```bash
   luxdmx restore --universe 0 --terminate-sacn --json
   ```

## Native MCP Mode
Run `luxdmx mcp` over stdio (JSON-RPC 2.0) for `probe_lighting`, `list_fixtures`, `list_gels`, `solve_color`, `apply_dmx`, `apply_scene`, `restore_universe`, and `license_status`. Write tools default `dry_run: true` and require `confirm: true`.

## Exit Codes
- `0` ok | `1` runtime/rollback | `2` usage/validation/missing `--yes` | `3` no nodes/interface, sACN priority conflict, or missing snapshot | `4` macOS Local Network permission or symlink denied | `5` Pro license required (`luxdmx license activate --key <KEY>`) | `130` interrupted (`SIGINT`/`SIGTERM`) after baseline restore
