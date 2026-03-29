# LLM Development GPU Environment

A ready-to-use LLM application development environment with NVIDIA GPU support for VS Code. Includes **LangChain**, **LlamaIndex**, **Hugging Face Transformers**, and API clients for OpenAI and Anthropic. Designed for wide GPU compatibility and suitable for both inference and fine-tuning.

> **Note:** This container is designed to be used as part of a VS Code Dev Container environment, not run directly. See the [full environment setup on GitHub](https://github.com/gperdrizet/llms-devcontainer) for devcontainer configuration and usage instructions.

> **CUDA version note:** This image is based on the NVIDIA PyTorch NGC 25.03 container with CUDA 12.8.1, supporting GPU architectures from Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200). CUDA 12.x is the last series to support Pascal — [CUDA 13.0 removed Pascal, Maxwell, and Volta support entirely](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html). Requires host driver ≥ 570.x on Linux.

## Features

- **Multi-Framework Support** – LangChain, LlamaIndex, and Hugging Face Transformers pre-installed
- **High-Performance Inference** – Local models via Ollama
- **API Clients** – OpenAI and Anthropic SDKs with LangChain integrations
- **Vector Store** – ChromaDB for embeddings and retrieval
- **Web UI** – Gradio for building interactive demos
- **NVIDIA GPU Acceleration** – PyTorch 2.7 from NVIDIA NGC with CUDA 12.8 and Blackwell support
- **VS Code Dev Container Ready** – Pre-configured `vscode` user for seamless devcontainer integration

## Included Software

| Component | Version |
|-----------|--------|
| Base Image | `nvcr.io/nvidia/pytorch:25.03-py3` |
| PyTorch | 2.7.0 (NGC build) |
| Python | 3.12 |
| CUDA | 12.8.1 |
| GPU Support | Pascal through Blackwell (sm_60 - sm_100) |

### LLM Frameworks
- `langchain` - LLM application framework
- `llama-index` - Data framework for LLM applications
- `transformers` - Hugging Face model hub and inference
- `smolagents` - Hugging Face agents framework

### API Clients
- `openai` - OpenAI API client
- `anthropic` - Anthropic Claude API client
- `ollama` - Ollama server and Python client for local models

### Vector Store & Embeddings
- `chromadb` - Embedded vector database
- `sentence-transformers` - Text embeddings

### Additional Tools
- `gradio` - Web UI framework
- `accelerate` - Model loading and distributed training
- `datasets` - Hugging Face datasets
- `tiktoken` - Token counting

## Usage with VS Code Dev Containers

This image is optimized for use with VS Code Dev Containers. The `vscode` user (UID 1000) is pre-configured with sudo access for a seamless development experience.

## Running Directly with Docker

You can also run the container directly with Docker:

```bash
docker run --gpus all -it -v $(pwd):/workspace gperdrizet/llms-gpu:latest bash
```

Or launch a Gradio app:

```bash
docker run --gpus all -p 7860:7860 -v $(pwd):/workspace gperdrizet/llms-gpu:latest \
    python your_gradio_app.py
```

## Requirements

- Docker with NVIDIA GPU support
- NVIDIA GPU with compatible drivers (Pascal architecture or newer, driver ≥ 570.x)

## License

See the [GitHub repository](https://github.com/gperdrizet/llms-devcontainer) for license information.
