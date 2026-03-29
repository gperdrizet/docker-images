# Docker Images

A collection of ready-to-use deep learning Docker images for VS Code Dev Containers, designed for AI/ML bootcamp students. GPU images are built with wide hardware compatibility (NVIDIA Pascal through Blackwell, sm_60-sm_100) so they work across diverse student hardware. All images include a pre-configured `vscode` user (UID 1000) with sudo access for seamless devcontainer integration.

> **CUDA version note:** GPU images use CUDA 12.8, supporting Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200). CUDA 12.x is the last series to support Pascal — [CUDA 13.0 removed Pascal, Maxwell, and Volta support entirely](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html). CUDA 12.8 requires host driver ≥ 570.x on Linux.

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

### PyTorch Wheel Commands

| Command | Description |
|---------|-------------|
| `make wheel-deeplearning-gpu` | Build PyTorch wheel for deeplearning-gpu |
| `make extract-wheel-deeplearning-gpu` | Extract wheel from deeplearning-gpu builder |

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
3. llms-gpu
4. llms-cpu
5. tensorflow-gpu *(archived)*
6. tensorflow-cpu *(archived)*

### 1. deeplearning-gpu

Full-featured deep learning environment with NVIDIA GPU support.

| Component | Version |
|-----------|---------|
| Base Image | `nvcr.io/nvidia/tensorflow:24.08-tf2-py3` |
| TensorFlow | 2.17 |
| PyTorch | 2.5.1 (custom wheel) |
| Keras | 3.x |
| Python | 3.10 |
| CUDA | 12.4 |
| GPU Support | Pascal - Hopper (sm_60 - sm_90) |

**Custom PyTorch Build:** PyTorch is built from source with wide GPU architecture support. The pre-built wheel is downloaded from GitHub Releases during image build. See [Rebuilding PyTorch Wheels](#rebuilding-pytorch-wheels) if you need to rebuild.

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, jupyterlab, keras_tuner, optuna, tensorboard

**DockerHub:** [`gperdrizet/deeplearning-gpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-gpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer)

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

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer)

---

### 3. llms-gpu

LLM application development environment with NVIDIA GPU support. Includes LangChain, LlamaIndex, Hugging Face Transformers, and API clients.

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.6.3-cudnn-devel-ubuntu22.04` |
| PyTorch | 2.5.1 (custom wheel) |
| Python | 3.11 |
| CUDA | 12.6 |
| GPU Support | Pascal - Hopper (sm_60 - sm_90) |

**Custom PyTorch Build:** PyTorch is built from source with wide GPU architecture support. The pre-built wheel is downloaded from GitHub Releases during image build. See [Rebuilding PyTorch Wheels](#rebuilding-pytorch-wheels) if you need to rebuild.

**LLM Frameworks:** langchain, llama-index, transformers, smolagents

**API Clients:** openai, anthropic, ollama

**Other packages:** chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-gpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/llms-gpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer)

---

### 4. llms-cpu

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

**Devcontainer repository:** [`github.com/gperdrizet/llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer)

---

## Archived Containers

The following containers are no longer actively maintained.

### 5. tensorflow-gpu *(archived)*

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

### 6. tensorflow-cpu *(archived)*

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

## Requirements

- **GPU images:** Docker with NVIDIA GPU support and compatible drivers
- **CPU images:** Docker

## Rebuilding PyTorch Wheels

The `llms-gpu` and `deeplearning-gpu` images use custom-built PyTorch wheels with wide GPU architecture support (Pascal through Hopper). Pre-built wheels are hosted on GitHub Releases and downloaded during image build.

### Why Custom Wheels?

Standard PyTorch wheels only support recent GPU architectures. Our custom builds include `sm_60` through `sm_90` for compatibility with diverse student hardware, from GTX 1060 to RTX 4090.

### When to Rebuild

Rebuild wheels when:
- Upgrading PyTorch version
- Adding/removing GPU architecture support
- Updating CUDA version in base image

### Build Commands

| Command | Description |
|---------|-------------|
| `make wheel-llms-gpu` | Build PyTorch wheel for llms-gpu (Python 3.11, CUDA 12.6) |
| `make wheel-deeplearning-gpu` | Build PyTorch wheel for deeplearning-gpu (Python 3.10, CUDA 12.4) |
| `make extract-wheel-llms-gpu` | Extract wheel from builder container |
| `make extract-wheel-deeplearning-gpu` | Extract wheel from builder container |

### Build Configuration

Override defaults via environment variables:

```bash
# Custom PyTorch version
make wheel-llms-gpu PYTORCH_VERSION=2.6.0

# Adjust build parallelism (default: 16)
make wheel-llms-gpu MAX_JOBS=8

# Custom GPU architectures
make wheel-llms-gpu CUDA_ARCH_LIST="7.0;7.5;8.0;8.6"
```

### Full Workflow

```bash
# 1. Build the wheel (takes 3-4 hours)
make wheel-llms-gpu

# 2. Extract wheel to ./wheels/
make extract-wheel-llms-gpu

# 3. Upload to GitHub Releases
gh release create pytorch-2.5.1-cu126 ./wheels/torch-2.5.1-cp311-cp311-linux_x86_64.whl \
  --title "PyTorch 2.5.1 CUDA 12.6 (Pascal-Hopper)" \
  --notes "Custom PyTorch wheel with sm_60-sm_90 support"

# 4. Update WHEEL_URL in Dockerfile and rebuild image
make build-llms-gpu
```

### Wheel Specifications

| Container | Python | CUDA | Wheel Name |
|-----------|--------|------|------------|
| llms-gpu | 3.11 | 12.6 | `torch-X.Y.Z-cp311-cp311-linux_x86_64.whl` |
| deeplearning-gpu | 3.10 | 12.4 | `torch-X.Y.Z-cp310-cp310-linux_x86_64.whl` |

## License

See individual container directories for license information.
