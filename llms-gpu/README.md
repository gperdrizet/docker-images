# LLM Development GPU Environment

A ready-to-use LLM application development environment with NVIDIA GPU support for VS Code. Includes **LangChain**, **LlamaIndex**, **Hugging Face Transformers**, **vLLM**, and API clients for OpenAI and Anthropic. Designed for wide GPU compatibility (Pascal+) and suitable for both inference and fine-tuning.

> **Note:** This container is designed to be used as part of a VS Code Dev Container environment, not run directly. See the [full environment setup on GitHub](https://github.com/gperdrizet/llms-devcontainer) for devcontainer configuration and usage instructions.

## Features

- **Multi-Framework Support** – LangChain, LlamaIndex, and Hugging Face Transformers pre-installed
- **High-Performance Inference** – vLLM for efficient LLM serving
- **API Clients** – OpenAI and Anthropic SDKs with LangChain integrations
- **Vector Store** – ChromaDB for embeddings and retrieval
- **Web UI** – Gradio for building interactive demos
- **NVIDIA GPU Acceleration** – PyTorch built from source with CUDA 12.6 for wide GPU support
- **VS Code Dev Container Ready** – Pre-configured `vscode` user for seamless devcontainer integration

## Included Software

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.6.3-cudnn-devel-ubuntu22.04` |
| PyTorch | Latest (built from source) |
| Python | 3.11 |
| CUDA | 12.6 |
| GPU Support | Pascal through Hopper (sm_60 - sm_90) |

### LLM Frameworks
- `langchain` - LLM application framework
- `llama-index` - Data framework for LLM applications
- `transformers` - Hugging Face model hub and inference
- `smolagents` - Hugging Face agents framework
- `vllm` - High-throughput LLM serving

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
- NVIDIA GPU with compatible drivers (Pascal architecture or newer)

## License

See the [GitHub repository](https://github.com/gperdrizet/llms-devcontainer) for license information.
