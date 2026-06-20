# LLM development Mac (ARM64) environment

A ready-to-use LLM application development environment for Apple Silicon Macs (M1/M2/M3). Includes **LangChain**, **LlamaIndex**, **Hugging Face Transformers**, and API clients for OpenAI and Anthropic. Built as a native `linux/arm64` image — runs in Docker Desktop without Rosetta emulation.

> **Note:** GPU acceleration is not available inside Docker containers on Apple Silicon: Metal/MPS is a macOS-only framework with no Docker passthrough. This image provides native ARM64 CPU performance only.

> **Note:** This container is designed to be used as part of a VS Code Dev Container environment, not run directly. See the [full environment setup on GitHub](https://github.com/gperdrizet/llms-devcontainer) for devcontainer configuration and usage instructions.

## 1. Features

- **Multi-framework support:** LangChain, LlamaIndex, and Hugging Face Transformers pre-installed
- **API clients:** OpenAI and Anthropic SDKs with LangChain integrations
- **Vector store:** ChromaDB for embeddings and retrieval
- **Web UI:** Gradio for building interactive demos
- **Native ARM64:** No Rosetta emulation — runs at native speed on Apple Silicon
- **VS Code Dev Container ready:** Pre-configured `vscode` user for seamless devcontainer integration

## 2. Included software

| Component | Version |
|-----------|---------|
| Base Image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| PyTorch | Latest (CPU, ARM64) |
| Python | 3.12 |

### 2.1. LLM frameworks
- `langchain` - LLM application framework
- `llama-index` - Data framework for LLM applications
- `transformers` - Hugging Face model hub and inference
- `smolagents` - Hugging Face agents framework

### 2.2. API clients
- `openai` - OpenAI API client
- `anthropic` - Anthropic Claude API client
- `ollama` - Ollama server and Python client for local models

### 2.3. Vector store and embeddings
- `chromadb` - Embedded vector database
- `sentence-transformers` - Text embeddings

### 2.4. Additional tools
- `gradio` - Web UI framework
- `accelerate` - Model loading and distributed training
- `datasets` - Hugging Face datasets
- `tiktoken` - Token counting

## 3. Usage with VS Code Dev Containers

This image is optimized for use with VS Code Dev Containers. The `vscode` user (UID 1000) is pre-configured with sudo access for a seamless development experience.

## 4. Running directly with Docker

```bash
docker run --rm -it \
  --platform linux/arm64 \
  -v $(pwd):/workspace \
  gperdrizet/llms-mac:latest bash
```

Or launch a Gradio app:

```bash
docker run --platform linux/arm64 -p 7860:7860 -v $(pwd):/workspace gperdrizet/llms-mac:latest \
    python your_gradio_app.py
```

## 5. Requirements

- Docker Desktop for Mac (Apple Silicon)

## 6. License

See the [GitHub repository](https://github.com/gperdrizet/llms-devcontainer) for license information.
