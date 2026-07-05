# llms images

LLM application development environment with LangChain, LlamaIndex, Hugging Face Transformers, and API clients. Three variants: NVIDIA GPU, CPU-only, and Apple Silicon.

---

## llms-nvidia

PyTorch is added via a custom-built wheel with wide GPU architecture support (see [Building Custom Wheels](../development/wheels.md)).

| Component | Version |
|-----------|--------|
| Base image | `nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04` |
| Python | 3.12 |
| CUDA | 12.8 |
| PyTorch | 2.11.0 (custom wheel) |
| GPU support | Pascal–Blackwell (sm_60–sm_100) |

**LLM frameworks:** langchain, llama-index, transformers, smolagents

**API clients:** openai, anthropic, ollama

**Other packages:** jupyterlab, ipykernel, ipywidgets, chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-nvidia`](https://hub.docker.com/repository/docker/gperdrizet/llms-nvidia/general)

---

## llms-cpu

| Component | Version |
|-----------|--------|
| Base image | `python:3.12-slim` |
| Python | 3.12 |
| PyTorch | Latest CPU (via pip) |

**LLM frameworks:** langchain, llama-index, transformers, smolagents

**API clients:** openai, anthropic, ollama

**Other packages:** jupyterlab, ipykernel, ipywidgets, chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-cpu`](https://hub.docker.com/repository/docker/gperdrizet/llms-cpu/general)

---

## llms-mac

Native `linux/arm64` image for Apple Silicon (M1/M2/M3). No Rosetta emulation. GPU acceleration is not available inside Docker on macOS.

| Component | Version |
|-----------|--------|
| Base image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| Python | 3.12 |
| PyTorch | Latest (CPU, ARM64) |

**LLM frameworks:** langchain, llama-index, transformers, smolagents

**API clients:** openai, anthropic, ollama

**Other packages:** jupyterlab, ipykernel, ipywidgets, chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-mac`](https://hub.docker.com/repository/docker/gperdrizet/llms-mac/general)
