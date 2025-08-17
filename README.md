# UnitedShare Development Kit (USDK) — One Code Base (Zig/C++/Cheerp/Flutter)

This repository is a **skeleton** for the UnitedShare One-Codebase approach:
- **FluentScript** (domain language) with CLI + App-Server integration
- **C++ Crow** sync server that **generates** Cheerp-powered client JS
- **Runner App** (C++) to run each plugin as a **Nanos UniKernel** with Admin UI
- **Zig** orchestrates build/link of C/C++ parts and provides REST/WebSocket
- **DuckDB** adapter stubs (WASM + native)
- **IFC** processing hooks (IfcOpenShell) and SDUI generation for Flutter Stac

> This is a starting point with build stubs & examples. Flesh out per your environment.
