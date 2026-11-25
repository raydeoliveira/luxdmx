---
name: Hardware Compatibility Report
about: Share test results for luxdmx on your physical hardware
title: "[HW] <device model> on <OS>"
labels: hardware-report
---

## Hardware Setup
- **OS & Architecture**: (e.g., macOS 15.x arm64, Ubuntu 24.04 x86_64)
- **Hardware Model / Interface**: (Art-Net 4 / sACN E1.31 node, DMX fixture make/model, and interface (Ethernet/Wi-Fi))
- **`luxdmx --version` output**:

## `probe` Output
```json
// paste output of `luxdmx probe --json` (redact any serial numbers you do not wish to share)
```

## What Worked / Quirks
- What commands succeeded cleanly?
- Did `--dry-run` or timed auto-revert / restore behave as expected?
- Any timeouts, firmware quirks, or unexpected VID/PIDs?
