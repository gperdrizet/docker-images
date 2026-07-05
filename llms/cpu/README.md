# LLM development CPU environment

A ready-to-use LLM application development environment for VS Code. Includes **LangChain**, **LlamaIndex**, **Hugging Face Transformers**, and API clients for OpenAI and Anthropic. Designed for CPU-only systems or development without GPU dependencies.

> **Note:** This container is designed to be used as part of a VS Code Dev Container environment, not run directly. See the [full environment setup on GitHub](https://github.com/gperdrizet/llms-devcontainer) for devcontainer configuration and usage instructions.

## 1. Features

- **Multi-framework support:** LangChain, LlamaIndex, and Hugging Face Transformers pre-installed
- **API clients:** OpenAI and Anthropic SDKs with LangChain integrations
- **Vector store:** ChromaDB for embeddings and retrieval
- **Web UI:** Gradio for building interactive demos
- **Lightweight and portable:** No GPU or CUDA dependencies required
- **VS Code Dev Container ready:** Pre-configured `vscode` user for seamless devcontainer integration

## 2. Included software

| Component | Version |
|-----------|---------|
| Base Image | `python:3.12-slim` |
| PyTorch | Latest (CPU) |
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

You can also run the container directly with Docker:

```bash
docker run -it -v $(pwd):/workspace gperdrizet/llms-cpu:latest bash
```

Or launch a Gradio app:

```bash
docker run -p 7860:7860 -v $(pwd):/workspace gperdrizet/llms-cpu:latest \
    python your_gradio_app.py
```

## 5. Requirements

- Docker

## 6. License

See the [GitHub repository](https://github.com/gperdrizet/llms-devcontainer) for license information.
