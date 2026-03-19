# Docker Images

A collection of ready-to-use deep learning Docker images for VS Code Dev Containers. All images include a pre-configured `vscode` user (UID 1000) with sudo access for seamless devcontainer integration.

## Quick Start

```bash
# Build all images
make build-all

# Push all images to Docker Hub
make push-all

# Build and push everything
make all

# Update DockerHub descriptions (requires .env file)
make update-readme-all
```

## Configuration

### DockerHub README Updates

To update repository descriptions on DockerHub, create a `.env` file in the project root:

```bash
DOCKERHUB_USERNAME=gperdrizet
DOCKERHUB_TOKEN=your-token-here
```

Create your DockerHub Personal Access Token at https://hub.docker.com/settings/security with **Read, Write, & Delete** permissions.

## Makefile Commands

### Build Commands

| Command | Description |
|---------|-------------|
| `make build-deeplearning-gpu` | Build deeplearning GPU image |
| `make build-deeplearning-cpu` | Build deeplearning CPU image |
| `make build-deeplearning` | Build both deeplearning images |
| `make build-tensorflow-gpu` | Build tensorflow GPU image |
| `make build-tensorflow-cpu` | Build tensorflow CPU image |
| `make build-tensorflow` | Build both tensorflow images |
| `make build-llms-gpu` | Build llms GPU image |
| `make build-llms-cpu` | Build llms CPU image |
| `make build-llms` | Build both llms images |
| `make build-all` | Build all images |

### Push Commands

| Command | Description |
|---------|-------------|
| `make push-deeplearning-gpu` | Push deeplearning GPU image |
| `make push-deeplearning-cpu` | Push deeplearning CPU image |
| `make push-deeplearning` | Push both deeplearning images |
| `make push-tensorflow-gpu` | Push tensorflow GPU image |
| `make push-tensorflow-cpu` | Push tensorflow CPU image |
| `make push-tensorflow` | Push both tensorflow images |
| `make push-llms-gpu` | Push llms GPU image |
| `make push-llms-cpu` | Push llms CPU image |
| `make push-llms` | Push both llms images |
| `make push-all` | Push all images |

### Combined Commands

| Command | Description |
|---------|-------------|
| `make all` | Build and push all images |

### README Update Commands

| Command | Description |
|---------|-------------|
| `make update-readme-deeplearning-gpu` | Update deeplearning-gpu DockerHub README |
| `make update-readme-deeplearning-cpu` | Update deeplearning-cpu DockerHub README |
| `make update-readme-tensorflow-gpu` | Update tensorflow-gpu DockerHub README |
| `make update-readme-tensorflow-cpu` | Update tensorflow-cpu DockerHub README |
| `make update-readme-llms-gpu` | Update llms-gpu DockerHub README |
| `make update-readme-llms-cpu` | Update llms-cpu DockerHub README |
| `make update-readme-all` | Update all DockerHub READMEs |

## Container Summaries

1. deeplearning-gpu
2. deeplearning-cpu
3. tensorflow-gpu
4. tensorflow-cpu
5. llms-gpu
6. llms-cpu

### 1. deeplearning-gpu

Full-featured deep learning environment with NVIDIA GPU support.

| Component | Version |
|-----------|---------|
| Base Image | `nvcr.io/nvidia/tensorflow:24.06-tf2-py3` |
| TensorFlow | 2.16 |
| PyTorch | 2.10 |
| Keras | 3.3 |
| Python | 3.10 |
| CUDA | 12.6 |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, jupyterlab, keras_tuner, optuna, tensorboard

**DockerHub:** [`gperdrizet/deeplearning-gpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/tensorflow-gpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-gpu`](https://github.com/gperdrizet/deeplearning-gpu)

---

### 2. deeplearning-cpu

Full-featured deep learning environment for CPU-only systems.

| Component | Version |
|-----------|---------|
| Base Image | `tensorflow/tensorflow:2.16.1-jupyter` |
| TensorFlow | 2.16 |
| PyTorch | 2.10 |
| Keras | 3.3 |
| Python | 3.10 |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, jupyterlab, keras_tuner, optuna, tensorboard

**DockerHub:** [`gperdrizet/deeplearning-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-cpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-cpu`](https://github.com/gperdrizet/deeplearning-cpu)

---

### 3. tensorflow-gpu

TensorFlow-focused environment with NVIDIA GPU support (no PyTorch).

| Component | Version |
|-----------|---------|
| Base Image | `nvcr.io/nvidia/tensorflow:24.06-tf2-py3` |
| TensorFlow | 2.16 |
| Keras | 3.3 |
| Python | 3.10 |
| CUDA | 12.6 |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, jupyterlab, keras_tuner, optuna, tensorboard

**DockerHub:** [`gperdrizet/tensorflow-gpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/tensorflow-gpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/tensorflow-gpu`](https://github.com/gperdrizet/tensorflow-gpu)

---

### 4. tensorflow-cpu

Lightweight TensorFlow environment for CPU-only systems (no PyTorch).

| Component | Version |
|-----------|---------|
| Base Image | `tensorflow/tensorflow:2.16.1-jupyter` |
| TensorFlow | 2.16 |
| Keras | 3.3 |
| Python | 3.10 |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, jupyterlab, keras_tuner, optuna, tensorboard

**DockerHub:** [`gperdrizet/tensorflow-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/tensorflow-cpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/tensorflow-cpu`](https://github.com/gperdrizet/tensorflow-cpu)

---

### 5. llms-gpu

LLM application development environment with NVIDIA GPU support. Includes LangChain, LlamaIndex, Hugging Face Transformers, vLLM, and API clients.

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.6.3-cudnn-devel-ubuntu22.04` |
| PyTorch | Latest (built from source) |
| Python | 3.11 |
| CUDA | 12.6 |
| GPU Support | Pascal - Hopper (sm_60 - sm_90) |

**LLM Frameworks:** langchain, llama-index, transformers, smolagents, vllm

**API Clients:** openai, anthropic, ollama

**Other packages:** chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-gpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/llms-gpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/llms-gpu`](https://github.com/gperdrizet/llms-gpu)

---

### 6. llms-cpu

Lightweight LLM application development environment for CPU-only systems.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.11-slim` |
| PyTorch | Latest (CPU) |
| Python | 3.11 |

**LLM Frameworks:** langchain, llama-index, transformers, smolagents

**API Clients:** openai, anthropic, ollama

**Other packages:** chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/llms-cpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/llms-cpu`](https://github.com/gperdrizet/llms-cpu)

---

## Requirements

- **GPU images:** Docker with NVIDIA GPU support and compatible drivers
- **CPU images:** Docker

## License

See individual container directories for license information.
