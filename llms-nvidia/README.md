# LLM development GPU environment

A ready-to-use LLM application development environment with NVIDIA GPU support for VS Code. Includes **LangChain**, **LlamaIndex**, **Hugging Face Transformers**, and API clients for OpenAI and Anthropic. Designed for wide GPU compatibility and suitable for both inference and fine-tuning.

> **Note:** This container is designed to be used as part of a VS Code Dev Container environment, not run directly. See the [full environment setup on GitHub](https://github.com/gperdrizet/llms-devcontainer) for devcontainer configuration and usage instructions.

> **CUDA version note:** This image uses a custom PyTorch 2.11.0 wheel built for CUDA 12.8.1, supporting GPU architectures from Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200). CUDA 12.x is the last series to support Pascal; [CUDA 13.0 removed Pascal, Maxwell, and Volta support entirely](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html). Requires host driver ≥ 570.x on Linux.

## 1. Features

- **Multi-framework support:** LangChain, LlamaIndex, and Hugging Face Transformers pre-installed
- **High-performance inference:** Local models via Ollama
- **API clients:** OpenAI and Anthropic SDKs with LangChain integrations
- **Vector store:** ChromaDB for embeddings and retrieval
- **Web UI:** Gradio for building interactive demos
- **NVIDIA GPU acceleration:** PyTorch 2.11.0 (custom wheel, sm_60-sm_100) with CUDA 12.8 and Blackwell support
- **VS Code Dev Container ready:** Pre-configured `vscode` user for seamless devcontainer integration

## 2. Included software

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04` |
| PyTorch | 2.11.0 (custom build, Pascal-Blackwell) |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | Pascal through Blackwell (sm_60 - sm_100) |

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

You can also run the container directly with Docker:

```bash
docker run --gpus all -it -v $(pwd):/workspace gperdrizet/llms-nvidia:latest bash
```

Or launch a Gradio app:

```bash
docker run --gpus all -p 7860:7860 -v $(pwd):/workspace gperdrizet/llms-nvidia:latest \
    python your_gradio_app.py
```

## 5. Requirements

- Docker with NVIDIA GPU support
- NVIDIA GPU with compatible drivers (Pascal architecture or newer, driver ≥ 570.x)

## 6. License

See the [GitHub repository](https://github.com/gperdrizet/llms-devcontainer) for license information.
