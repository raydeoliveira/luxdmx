# LuxDMX

> **Product Hub:** [raymonddeoliveira.com/software](https://www.raymonddeoliveira.com/software#luxdmx) · **Polar Storefront:** [polar.sh/raymond-de-oliveira](https://polar.sh/raymond-de-oliveira) · **Verified MCP:** [Glama](https://glama.ai/mcp/servers/raydeoliveira/luxdmx) · **Free Core:** `brew tap raydeoliveira/tap && brew install luxdmx`

Zero-driver macOS LAN lighting CLI and stdio MCP server that discovers and controls Art-Net 4 (UDP `6454`) and ANSI E1.31 sACN (UDP `5568`) fixtures with CIE Planckian/`duv` color science, Lee/Rosco gel presets, multi-universe atomic scenes, pre-write snapshots, and 15-second auto-revert — in one **771 KB** zero-dependency native binary.

## Measured Footprint

Measured on Apple Silicon (`arm64-apple-macos14.0`, Swift 6.4.2):

| Metric | Measured Value |
|---|---|
| Stripped binary (`arm64`) | `789,360 bytes` (`771 KB`) |
| Compressed release tarball | `307,948 bytes` (`301 KB`, binary + docs + MCP manifest) |
| External runtime dependencies | `0` (Swift stdlib, Foundation, Darwin BSD sockets) |
| `--version` latency (15 subprocess runs) | `8.26 ms` median (`6.80–10.74 ms`) |
| Automated test suite (22 tests, 5 suites) | `3.18 s` (includes live UDP loopback, PTY `SIGINT`, Polar HTTP, MCP stdio) |

## What It Does / What It Does Not Do

| Capability | Status | Tier |
|---|---|---|
| `probe`: `ArtPoll` discovery + passive UDP `6454`/`5568` sniff | Included | Free |
| `fixtures` & `gels`: 10 cinema fixture profiles (Aputure, ARRI, Astera, WLED) + 16 Lee/Rosco gels | Included | Free |
| `solve`: CIE 1931/1960 UCS Planckian CCT + `duv` tint & gel DMX channel math | Included | Free |
| `apply`: raw `--channels` or 2ch `--cct`/`--dim` single-universe output with snapshot | Included | Free |
| `apply --dry-run` & `scene --dry-run` previews (zero UDP packets, zero state writes) | Included | Free |
| `watch`: bounded passive DMX frame & channel delta capture | Included | Free |
| `restore`: atomic 512-byte snapshot replay + E1.31 `Stream_Terminated` (`0x40`) | Included | Free |
| Read-only & dry-run stdio MCP tools (`luxdmx mcp`) | Included | Free |
| Live `apply` with `--gel`, `--duv` tint, or multi-emitter `--fixture` (RGB/RGBW/RGBWW/RGBMA/CCT-Tint) | Included | Pro ($29) |
| Live multi-universe atomic `scene --file` execution with pre-flight conflict check & rollback | Included | Pro ($29) |
| Pro MCP write tools (`apply_dmx` with gels/fixtures, live `apply_scene`) | Included | Pro ($29) |

**Explicit Non-Goals & Current Verification Limits:**
- **macOS Apple Silicon (`arm64`, macOS 14+) release binaries.** Zero kernel extensions, DriverKit drivers, `libusb`, or FTDI USB-serial bridges.
- **No BLE mesh or proprietary HTTP bridges** (no Sidus Mesh BLE, Hue, or Elgato HTTP APIs; fixtures must speak Art-Net 4 or E1.31 sACN over LAN/Wi-Fi).
- **No GUI timeline editor or 44 Hz continuous chase daemon** in v0.1.0; no `ArtAddress`/`ArtIpProg`/RDM node config flashing.
- **Hardware testing disclosure:** Darwin POSIX UDP multi-interface probing (`en0`, `lo0`), `ArtPoll`/`ArtPollReply` discovery, `ArtDmx` & `E1.31` slot delivery and flags (`Preview_Data 0x80`, `Stream_Terminated 0x40`), PTY `kill(SIGINT)` restore, atomic `fsync`+`rename` symlink-safe snapshots, loopback HTTP Polar.sh licensing, and `luxdmx mcp` stdio JSON-RPC 2.0 are all verified by automated tests. Physical third-party Art-Net/sACN fixtures have **not** yet been attached to this host — test live universes with `--dry-run` and `probe` first.

## Install & Uninstall

### Homebrew (Recommended)
```bash
brew tap raydeoliveira/tap
brew install raydeoliveira/tap/luxdmx
luxdmx --version
```

### From Release Tarball
```bash
tar -xzf luxdmx-0.1.0-macos-arm64.tar.gz
shasum -a 256 -c SHA256SUMS.txt
install -m 755 luxdmx-0.1.0-macos-arm64/luxdmx /usr/local/bin/luxdmx
luxdmx --version
```

### Build From Source (Swift 6, macOS 14+)
```bash
# Commercial build (Free Core + Polar.sh Pro activation):
swift build -c release
swift test

# Open-Source Edition build (all features unlocked offline, zero network calls):
LUXDMX_EDITION=oss swift build -c release
LUXDMX_EDITION=oss swift test
```

### Uninstall
```bash
rm -f /usr/local/bin/luxdmx
rm -rf ~/.config/luxdmx ~/.local/state/luxdmx
```

## Quick Start

### 1. Probe LAN Interfaces & Discover Nodes
```bash
luxdmx probe --timeout-ms 300 --json
```
Real output on Apple Silicon Mac:
```json
{"command":"probe","data":{"artnet_nodes":[],"interfaces":[{"broadcast":"192.168.139.255","ipv4":"192.168.139.3","isLoopback":false,"isPointToPoint":false,"isUp":true,"name":"bridge100"},{"broadcast":"192.168.7.255","ipv4":"192.168.4.27","isLoopback":false,"isPointToPoint":false,"isUp":true,"name":"en0"},{"broadcast":"192.168.7.255","ipv4":"192.168.4.28","isLoopback":false,"isPointToPoint":false,"isUp":true,"name":"en5"},{"ipv4":"127.0.0.1","isLoopback":true,"isPointToPoint":false,"isUp":true,"name":"lo0"}],"observed_universes":[],"selected_interface":{"broadcast":"192.168.7.255","ipv4":"192.168.4.27","isLoopback":false,"isPointToPoint":false,"isUp":true,"name":"en0"}},"error":null,"ok":true,"schema_version":1}
```

### 2. Solve Cinema Gels & Multi-Emitter DMX Channels
```bash
luxdmx solve --gel L201 --dim 80 --fixture aputure-600c-rgbww --json
```
Real output:
```json
{"command":"solve","data":{"cct_k":5700,"dim_percent":80,"duv":0,"fixture_id":"aputure-600c-rgbww","fixture_mode":"rgbww","gel_code":"L201","linear_rgb":{"b":1,"g":0.78,"r":0.56},"start_channel":1,"updates":[{"channel":1,"value":0},{"channel":2,"value":45},{"channel":3,"value":90},{"channel":4,"value":24},{"channel":5,"value":90}]},"error":null,"ok":true,"schema_version":1}
```

### 3. Dry-Run Preview, Live Apply, Multi-Universe Scene & MCP
```bash
# Preview slot diff without sending packets or touching snapshots (Free):
luxdmx apply --proto sacn --universe 1 --cct 4600 --dim 50 --dry-run --json

# Live single-universe write with 15s interactive confirmation watchdog (Free):
luxdmx apply --proto sacn --universe 1 --channels 1=255,2=128 --confirm-timeout 15 --json

# Instant snapshot replay + E1.31 Stream_Terminated cleanup (Free):
luxdmx restore --universe 0 --terminate-sacn --json

# Activate Pro license via Polar.sh (validates once, 14-day offline grace, zero telemetry):
luxdmx license activate --key <YOUR_POLAR_KEY>

# Run multi-universe atomic scene (Pro):
luxdmx scene --file scene.json --yes --json

# Start stdio JSON-RPC 2.0 MCP server for Claude Code, Codex, Cursor, or Antigravity:
luxdmx mcp
```

## Safety & Rollback

Every DMX mutation enforces the 6-stage hardware safety chain:
1. **Non-TTY Fail-Closed**: Refuses live output when stdin is non-interactive unless `--yes` or `--dry-run` is explicitly passed (exit `2`).
2. **Pre-Write Sniff & Priority Protection**: Listens (`--sniff-ms 250`) for active frames; higher-priority remote sACN sources block the write cleanly (exit `3`, `SACN_PRIORITY_CONFLICT`).
3. **Dry-Run Zero-Packet Invariant**: `--dry-run` outputs exact per-slot diffs while sending `0` UDP packets and leaving disk state untouched.
4. **Symlink-Safe Atomic Snapshots**: Rejects symlinks via `lstat` (exit `4`) and writes 512-byte baseline slots using `O_EXCL | O_NOFOLLOW`, `0600` mode, `fsync`, and `rename` to `$XDG_STATE_HOME/luxdmx/snapshots/u<N>.json`.
5. **Timed & Signal-Safe Auto-Revert**: Waits `--confirm-timeout` seconds (default `15s`); timeout, decline, or `SIGINT`/`SIGTERM` (`Ctrl-C`) replays the baseline frame plus 3 E1.31 `Stream_Terminated` (`0x40`) frames.
6. **Deterministic Manual Restore**: `luxdmx restore` replays saved snapshots and sends E1.31 termination on demand.

## Exit Codes & CLI Contract

Every command accepts `--json` (before or after the subcommand) and emits `{"schema_version":1,"ok":true|false,"command":"...","data":...,"error":...}` to `stdout` (diagnostics only on `stderr`). Run `luxdmx --describe` for the full JSON capability manifest or `luxdmx --help` for full usage.

| Exit Code | Meaning |
|---|---|
| `0` | Success (`"ok": true`) |
| `1` | Runtime/socket error, corrupt snapshot, or auto-rollback triggered |
| `2` | Invalid CLI usage, universe/channel/CCT bounds, or missing `--yes` on non-TTY |
| `3` | No reachable interface, sACN priority conflict, or missing snapshot |
| `4` | Local Network permission denied (`EACCES`/`EPERM`) or symlink rejected |
| `5` | Pro license required or invalid/expired Polar.sh key (omitted in `LUXDMX_EDITION=oss`) |
| `130` | Interrupted by `SIGINT`/`SIGTERM` after automatic baseline restore |

## License & Support

- Commercial binary distribution is licensed under [LICENSE](LICENSE) (Free Core + `$29` one-time Perpetual Pro license via Polar.sh, valid for up to 3 personal Macs, offline-capable with zero telemetry).
- Security & vulnerability disclosure: [SECURITY.md](SECURITY.md).
- AI Agent integration docs: [SKILL.md](SKILL.md) and [server.json](server.json).
