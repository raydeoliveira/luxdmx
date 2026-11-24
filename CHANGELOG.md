# Changelog

## 0.1.0
- Initial Swift 6 Clean Architecture implementation (`LuxdmxCore`, `LuxdmxAdapters`, `LuxdmxCLI`) with zero external dependencies.
- Added clean-room Art-Net 4 (`ArtPoll`, `ArtPollReply`, `ArtDmx`) and ANSI E1.31-2018 (`sACN` data + `Preview_Data` / `Stream_Terminated`) codecs with strict 12-bit Flags&Length bounds checking.
- Added CIE 1931/1960 UCS Planckian CCT + `duv` tint color science, 10 built-in cinema fixture profiles (Aputure, ARRI SkyPanel, Astera Titan, WLED, generic), and 16 Lee/Rosco gel presets (`solve`, `fixtures`, `gels`, `apply`).
- Added multi-universe atomic `scene` execution, bounded live `watch` delta monitor, hardened Polar.sh licensing (`LUXDMX_EDITION=oss` / `-DOSS_EDITION` compile seam), and JSON-RPC 2.0 stdio `luxdmx mcp` server.
- Fixed red-team defects `STW-008`, `STW-009`, `STW-010` (symlink `lstat` rejection, `O_NOFOLLOW`, E1.31 12-bit length checks, poll-guarded confirmation `read`, simultaneous 2-fd `poll`, loopback target snapshot fidelity, strict CLI flag parsing).
- Added 22 multi-tier unit, fault, PTY `SIGINT`, Polar loopback HTTP, and MCP stdio tests plus deterministic `.tar.gz`, `.mcpb`, Homebrew formula, `SKILL.md`, and `glama.json` release packaging.
