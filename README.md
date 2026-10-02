# Jarvis-by-Delight

> **Personal AI, On Personal Devices** — A modular, local-first personal AI assistant framework and desktop application with composable intelligence primitives, energy/FLOPs efficiency tracking, and adaptive local learning.

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![Python](https://img.shields.io/badge/python-%3E%3D3.10-3776AB.svg?logo=python&logoColor=white)](pyproject.toml)
[![Rust](https://img.shields.io/badge/rust-1.88%2B-orange.svg?logo=rust&logoColor=white)](rust/Cargo.toml)
[![Tauri](https://img.shields.io/badge/tauri-v2-24C8DB.svg?logo=tauri&logoColor=white)](frontend/src-tauri/tauri.conf.json)
[![React](https://img.shields.io/badge/react-19-61DAFB.svg?logo=react&logoColor=white)](frontend/package.json)

---

## Overview

**Jarvis-by-Delight** is a local-first personal AI platform engineered for privacy, speed, and intelligence efficiency. While most AI assistants route every query through remote cloud endpoints, Jarvis-by-Delight runs locally on personal hardware by default, escalating to frontier cloud models only when explicitly requested or required.

### Core Pillars

1. **Local-First Privacy**: Operates fully on-device with Ollama, MLX, vLLM, or Apple Foundation Models. Zero data leaves your machine unless you enable cloud providers.
2. **Resource-Aware Intelligence**: Treats energy consumption, FLOPs, latency, and token cost as first-class operational constraints alongside output accuracy.
3. **Multi-Agent Runtime**: Modular execution engine supporting ReAct reasoning, CodeAct Python execution, continuous long-horizon monitoring, and automated briefings.
4. **Extensible Skills Architecture**: Compatible with the `agentskills.io` standard, allowing dynamic skill discovery, catalog synchronization, and optimization loops.
5. **Modern Desktop Experience**: Native desktop app built with Tauri v2, React 19, Tailwind CSS, and shadcn UI, featuring live energy telemetry and trace inspection.

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                 Desktop App (Tauri v2 + React 19)           │
│     Chat Interface • Energy Telemetry • Trace Inspector     │
└──────────────────────────────┬──────────────────────────────┘
                               │ IPC / WebSocket
┌──────────────────────────────▼──────────────────────────────┐
│                    Jarvis Python Orchestrator                │
│    • FastAPI Server       • Scheduler & Memory (FAISS/BM25)  │
│    • Agent Dispatcher     • Energy Monitoring (pynvml/zeus) │
└──────────────┬──────────────────────────────┬───────────────┘
               │                              │
┌──────────────▼─────────────┐ ┌──────────────▼───────────────┐
│     PyO3 Native Core       │ │       Inference Engines       │
│  Rust Workspace (17 Crates)│ │  • Ollama / vLLM / MLX (Local)│
│  Fast sessions, MCP, tools │ │  • Claude / GPT / Gemini (Cloud)│
└────────────────────────────┘ └──────────────────────────────┘
```

---

## Built-in Agents

Jarvis-by-Delight ships with eight specialized built-in agents across three execution modalities:

| Agent | Mode | Purpose |
| :--- | :--- | :--- |
| `morning_digest` | **Scheduled** | Daily multi-source briefing from email, calendar, tasks, and news with neural voice synthesis |
| `deep_research` | **On-demand** | Multi-hop autonomous research across local indexed documents and web queries with structured citations |
| `monitor_operative` | **Continuous** | Long-horizon system, inbox, and service monitoring with memory compaction and state checkpoints |
| `orchestrator` | **On-demand** | Multi-turn reasoning supervisor with dynamic tool selection and task decomposition |
| `native_react` | **On-demand** | Thought-Action-Observation loop with iterative execution |
| `native_openhands` | **On-demand** | CodeAct paradigm agent that writes, tests, and executes Python code in sandboxed environments |
| `operative` | **Continuous** | Autonomous persistent assistant with state persistence |
| `simple` | **On-demand** | Lightweight, zero-tool conversational assistant for rapid queries |

---

## Skills Ecosystem

Agents dynamically discover, install, and utilize skills following the open agent skills specification:

```bash
# Install skills from public sources
jarvis skill install hermes:arxiv
jarvis skill sync hermes --category research

# Execute a task using installed skills
jarvis ask "Use the code-explainer skill to explain this algorithm: quicksort in Python"

# Optimize skills using local trace logs
jarvis optimize skills --policy dspy

# Benchmark skill performance and latency
jarvis bench skills --max-samples 5 --seeds 42
```

---

## Quick Start

### 1. Prerequisites

- **Python**: 3.10 to 3.13
- **uv**: Modern Python package and environment manager (`curl -LsSf https://astral.sh/uv/install.sh | sh`)
- **Node.js**: 22+ (only required for desktop frontend development)
- **Rust**: 1.88+ (only required if compiling native crates from source)

### 2. Installation & Setup

```bash
# Clone the repository
git clone https://github.com/delightc123/Jarvis-by-Delight.git
cd Jarvis-by-Delight

# Sync dependencies with uv
uv sync --extra dev

# Run doctor check to verify local inference engines and hardware
uv run jarvis doctor
```

### 3. Usage

```bash
# Launch interactive terminal chat
uv run jarvis

# Start the desktop web GUI and local API server
uv run jarvis gui

# Initialize an agent preset
uv run jarvis init --preset morning-digest-minimal --force

# Inspect system status and active skills
uv run jarvis status
```

---

## Hardware Acceleration & Energy Metrics

Jarvis-by-Delight includes native hooks for system energy profiling and hardware acceleration:

- **Apple Silicon**: Metal Performance Shaders (MPS), MLX backend, and IOReport SOC energy tracking.
- **NVIDIA CUDA**: TensorRT / vLLM acceleration and real-time power measurement via NVML.
- **AMD ROCm**: ROCm inference support and power telemetry via AMDSMI.
- **CPU / Generic**: Quantized llama.cpp / Ollama execution with low-resource footprint.

---

## Project Structure

```
Jarvis-by-Delight/
├── assets/                  # Branding, icons, and media
├── configs/                 # Default agent, engine, and channel configurations
├── desktop/                 # Desktop application bundle configuration
├── docs/                    # Documentation and guides
├── frontend/                # React 19 + Vite + Tailwind desktop user interface
│   └── src-tauri/           # Tauri v2 native wrapper configuration
├── rust/                    # High-performance Rust workspace (17 crates)
│   └── crates/              # Core engine, MCP, security, and PyO3 bindings
├── scripts/                 # Setup, verification, and deployment scripts
├── src/
│   └── openjarvis/          # Core Python agent framework and CLI
│       ├── agents/          # Agent implementations (ReAct, CodeAct, Orchestrator)
│       ├── channels/        # Chat integrations (Telegram, Discord, Slack, etc.)
│       ├── engines/         # Inference backends (Ollama, MLX, vLLM, Cloud)
│       ├── memory/          # FAISS, BM25, and vector retrieval pipelines
│       └── tools/           # File, web, shell, and custom tools
├── tests/                   # Pytest test suite
├── pyproject.toml           # Python package definition and dependencies
├── mkdocs.yml               # MkDocs documentation configuration
└── LICENSE                  # Apache 2.0 License
```

---

## Contributing

Contributions are welcome! Please consult [CONTRIBUTING.md](CONTRIBUTING.md) and our [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before submitting pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feat/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feat/amazing-feature`)
5. Open a Pull Request

---

## License & Attribution

Created and maintained by **Delight Chukwu** ([@delightc123](https://github.com/delightc123)).

Licensed under the **Apache License 2.0**. See the [LICENSE](LICENSE) file for complete terms and conditions.
