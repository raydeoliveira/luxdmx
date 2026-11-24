# Polar.sh Product Listing — LuxDMX Pro (macOS Apple Silicon)

> Use this copy directly when creating the LuxDMX Pro product in your Polar.sh dashboard (`polar.sh`).
> Enable Polar's built-in **License Keys** benefit (prefix: `LUXD`, activation limit: `3` machines per buyer, expiration: never / perpetual).

---

## Product Title
**LuxDMX Pro — Zero-Driver Art-Net 4 & sACN Lighting CLI + MCP Server (macOS)**

## Price & Billing Model
- **$29 USD** — One-time purchase (Perpetual License, v0.x updates included, up to 3 personal Macs). Replaces `$99–$199/yr` OEM tablet-locked DMX subscriptions.
- **Free Core Tier** included in the exact same single native binary (`probe`, `fixtures`, `gels`, `solve`, raw single-universe `apply`, `--dry-run`, `watch`, `restore`, read-only/dry-run MCP).

## Tagline (1-sentence summary)
Control studio and stage DMX lights over Art-Net 4 and sACN directly from your Mac terminal or AI agent — zero kernel drivers, zero OEM subscriptions, with atomic snapshots and 15-second auto-revert.

## What Is Included in Pro ($29 Perpetual)
- **Live Calibrated Gel & CIE Tint Output (`apply --gel` / `--duv` / `--fixture`)**: Transmit 16 Lee & Rosco cinema gels (`L201`, `L204`, `L244`, `R26`, `R80`, etc.), CIE 1960 UCS `duv` green/magenta tint shifts, and multi-emitter RGB/RGBW/RGBWW/RGBMA/CCT-Tint DMX mappings (Aputure, ARRI SkyPanel, Astera Titan, WLED).
- **Multi-Universe Atomic Scene Engine (`scene --file`)**: Pre-flight validate and sniff all target universes before writing, enforce sACN priority protection across every universe, save atomic snapshots, and roll back every cued universe cleanly on timeout or `Ctrl-C`.
- **Full AI-Agent MCP Server (`luxdmx mcp`)**: Enables live `apply_dmx` (gel/duv/multi-emitter) and `apply_scene` tools over stdio JSON-RPC 2.0 for Claude Code, Codex, Cursor, and Antigravity.

## Free Core vs. Pro Comparison

| Feature | Free Core | Pro ($29 one-time) |
|---|---|---|
| `probe` (`ArtPoll` + UDP `6454`/`5568` discovery) | Included | Included |
| `fixtures` & `gels` catalog + CIE `solve` math | Included | Included |
| `apply` raw `--channels` or 2ch `--cct`/`--dim` | Included | Included |
| `apply --dry-run` & `scene --dry-run` previews | Included | Included |
| `watch` bounded live DMX frame & delta capture | Included | Included |
| `restore` atomic 512-byte snapshot + E1.31 terminate | Included | Included |
| Live `apply` with `--gel`, `--duv`, or multi-emitter `--fixture` | — | Included |
| Live multi-universe atomic `scene` execution | — | Included |
| Live Pro MCP write tools (`apply_dmx` / `apply_scene`) | — | Included |

## Requirements & Honest Limits
- **OS & Architecture**: macOS 14.0+ on Apple Silicon (`arm64`).
- **Permissions**: Uses standard macOS user-space POSIX BSD UDP sockets (`0` kernel extensions, `0` FTDI USB drivers). First LAN broadcast/multicast prompts macOS Local Network permission; denials exit cleanly with code `4` and remediation instructions.
- **Verification Disclosure**: Verified across Darwin BSD `en0` and `127.0.0.1` UDP loopback sockets (including real PTY `SIGINT` rollback), loopback HTTP Polar.sh licensing, and compiled MCP stdio tests. No physical Art-Net/sACN fixtures were attached during automated testing; verify with `--dry-run` first. A 14-day refund policy applies if your lighting hardware rejects standard Art-Net 4 / E1.31 frames.

---

## Published Storefront & Directory Links
- **Checkout Link ($29 one-time):** https://buy.polar.sh/polar_cl_Gk5jd6VHJSUwKgvf186L8EyTDH8s4OsNmQOvG491AaB
- **Polar Product ID:** `1fed2f57-6ec5-40f8-93ae-e883b329caa3`
- **Polar Benefit — License Keys (`LUXD`):** max `3` activations, perpetual (no expiration)
- **Polar Benefit — File Downloads:** `luxdmx-0.1.0-macos-arm64.tar.gz`, `luxdmx-0.1.0-macos-arm64.mcpb`, `SHA256SUMS.txt`
- **Glama Verified MCP Listing:** https://glama.ai/mcp/servers/raydeoliveira/luxdmx
