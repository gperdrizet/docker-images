# Docker Images

[![CI](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml/badge.svg)](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml)
[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.11.0-EE4C2C?logo=pytorch&logoColor=white)](https://pytorch.org/)
[![TensorFlow](https://img.shields.io/badge/TensorFlow-2.17-FF6F00?logo=tensorflow&logoColor=white)](https://www.tensorflow.org/)
[![CUDA](https://img.shields.io/badge/CUDA-12.8-76B900?logo=nvidia&logoColor=white)](https://developer.nvidia.com/cuda-toolkit)
[![Transformers](https://img.shields.io/badge/🤗_Transformers-latest-FFD21E)](https://huggingface.co/docs/transformers)

[![Docker Pulls datascience-nvidia](https://img.shields.io/docker/pulls/gperdrizet/datascience-nvidia?label=datascience-nvidia&logo=docker)](https://hub.docker.com/r/gperdrizet/datascience-nvidia)
[![Docker Pulls datascience-cpu](https://img.shields.io/docker/pulls/gperdrizet/datascience-cpu?label=datascience-cpu&logo=docker)](https://hub.docker.com/r/gperdrizet/datascience-cpu)
[![Docker Pulls datascience-mac](https://img.shields.io/docker/pulls/gperdrizet/datascience-mac?label=datascience-mac&logo=docker)](https://hub.docker.com/r/gperdrizet/datascience-mac)
[![Docker Pulls deeplearning-nvidia](https://img.shields.io/docker/pulls/gperdrizet/deeplearning-nvidia?label=deeplearning-nvidia&logo=docker)](https://hub.docker.com/r/gperdrizet/deeplearning-nvidia)
[![Docker Pulls deeplearning-cpu](https://img.shields.io/docker/pulls/gperdrizet/deeplearning-cpu?label=deeplearning-cpu&logo=docker)](https://hub.docker.com/r/gperdrizet/deeplearning-cpu)
[![Docker Pulls deeplearning-mac](https://img.shields.io/docker/pulls/gperdrizet/deeplearning-mac?label=deeplearning-mac&logo=docker)](https://hub.docker.com/r/gperdrizet/deeplearning-mac)
[![Docker Pulls llms-nvidia](https://img.shields.io/docker/pulls/gperdrizet/llms-nvidia?label=llms-nvidia&logo=docker)](https://hub.docker.com/r/gperdrizet/llms-nvidia)
[![Docker Pulls llms-cpu](https://img.shields.io/docker/pulls/gperdrizet/llms-cpu?label=llms-cpu&logo=docker)](https://hub.docker.com/r/gperdrizet/llms-cpu)
[![Docker Pulls llms-mac](https://img.shields.io/docker/pulls/gperdrizet/llms-mac?label=llms-mac&logo=docker)](https://hub.docker.com/r/gperdrizet/llms-mac)

A collection of containerized development environments for AI/ML and data science education, designed for use with VS Code Dev Containers.

| Image | Base | Purpose |
|---|---|---|
| `datascience-nvidia` | `nvidia/cuda:12.8.1-runtime` | Intro data science + GPU acceleration |
| `datascience-cpu` | `python:3.12-slim` | Intro data science on CPU |
| `datascience-mac` | `python:3.12-slim` | Intro data science on Apple Silicon |
| `deeplearning-nvidia` | NGC TensorFlow 25.02 | TensorFlow + PyTorch on NVIDIA GPU |
| `deeplearning-cpu` | `python:3.12-slim` | TensorFlow + PyTorch on CPU |
| `deeplearning-mac` | `python:3.12-slim` | TensorFlow + PyTorch on Apple Silicon |
| `llms-nvidia` | `nvidia/cuda:12.8.1-cudnn-runtime` | LLM development on NVIDIA GPU |
| `llms-cpu` | `python:3.12-slim` | LLM development on CPU |
| `llms-mac` | `python:3.12-slim` | LLM development on Apple Silicon |

### Goals

1. **Eliminate setup friction**: students use a template devcontainer repo, clone it, and open it in VS Code. No manual environment configuration required. 
2. **Provide wide hardware support**: GPU images are built with the widest hardware compatibility possible (Pascal through Blackwell). CPU fallbacks are provided for machines without a compatible GPU, and a native `linux/arm64` image supports Apple Silicon Macs.
3. **Lower barrier to entry**: students can use whatever machine they have to get started, and at time of writing a 16GB NVIDIA P100 can be had on EBay for ~$90. This allows students to train deeplearning models and host LLMs and other generative models without dependence on proprietary APIs, expensive cloud compute or spending thousands of dollars on a GPU.
4. **Standardize development environments**: students use the most similar software stack possible, regardless of platform. This facilitates community learning and eases the troubleshooting and dev/ML ops burden on the instructor.

### Design rationale

The `datascience-*` images provide a lightweight environment for intro Python and ML classes: numpy, pandas, scikit-learn, xgboost, matplotlib, seaborn, plotly, jupyterlab, and optuna. The `datascience-mac`, `deeplearning-mac`, and `llms-mac` variants target Apple Silicon (M1/M2/M3) and are built as native `linux/arm64` images.

The `deeplearning-nvidia` image is based on NVIDIA's official NGC TensorFlow container, which provides a fully validated CUDA + cuDNN + TensorFlow stack that supports Pascal (sm_60) out of the box. PyTorch is then added via a custom-built wheel, as official PyTorch CUDA 12.x wheels dropped Pascal support. The `llms-nvidia` image follows the same custom-wheel approach but on a minimal `nvidia/cuda` base, since it doesn't need TensorFlow. This combination ensures all NVIDIA images work on Pascal through Blackwell hardware with no changes to student workflow. CPU images use `python:3.12-slim` with the same Python packages, providing a consistent environment for CPU-only machines.

## Contents

- [1. Requirements](#1-requirements)
- [2. Devcontainer repositories](#2-devcontainer-repositories)
- [3. Standalone usage](#3-standalone-usage)
  - [3.1. JupyterLab](#31-jupyterlab)
  - [3.2. VS Code: Attach to Running Container](#32-vs-code-attach-to-running-container)
- [4. Container summaries](#4-container-summaries)
  - [4.1. datascience-nvidia](#41-datascience-nvidia)
  - [4.2. datascience-cpu](#42-datascience-cpu)
  - [4.3. datascience-mac](#43-datascience-mac)
  - [4.4. deeplearning-nvidia](#44-deeplearning-nvidia)
  - [4.5. deeplearning-cpu](#45-deeplearning-cpu)
  - [4.6. deeplearning-mac](#46-deeplearning-mac)
  - [4.7. llms-nvidia](#47-llms-nvidia)
  - [4.8. llms-cpu](#48-llms-cpu)
  - [4.9. llms-mac](#49-llms-mac)
- [5. Development](#5-development)
  - [5.1. Releasing a new version](#51-releasing-a-new-version)
  - [5.2. Makefile reference](#52-makefile-reference)
  - [5.3. CI/CD infrastructure](#53-cicd-infrastructure)
  - [5.4. Building linux/ARM64 for macOS](#54-building-linuxarm64-for-macos)
  - [5.5. Building custom wheels](#55-building-custom-wheels)
- [6. License](#6-license)

## 1. Requirements

- **GPU images:** Docker with NVIDIA GPU support and host driver >= 570.x (required for CUDA 12.8)
- **CPU images:** Docker

> **CUDA version note:** GPU images use CUDA 12.8, supporting Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200). CUDA 12.x is the last series to support Pascal; [CUDA 13.0 removed Pascal, Maxwell, and Volta support entirely](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html).

## 2. Devcontainer repositories

The devcontainer repositories consume the images built here and provide the rest of the configuration needed to create a basic repository for data science, deeplearning or LLM development projects. Students click 'Use this template' on GitHub, clone the resulting repository and then start the container with VS Code's `Open folder in container` command. It's also possible to use the CPU only images in GitHub Codespaces.

| Repository | Images used | Description |
|------------|-------------|-------------|
| [`gperdrizet/datascience-devcontainer`](https://github.com/gperdrizet/datascience-devcontainer) | `datascience-nvidia`, `datascience-cpu`, `datascience-mac` | Dev Container for intro data science |
| [`gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer) | `deeplearning-nvidia`, `deeplearning-cpu`, `deeplearning-mac` | Dev Container for deep learning (TensorFlow + PyTorch) |
| [`gperdrizet/llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer) | `llms-nvidia`, `llms-cpu`, `llms-mac` | Dev Container for LLM application development |

The devcontainer configurations handle additional environment and repository set-up such as GPU pass-through, environment variables, publishing common ports (for e.g. Streamlit, Gradio, TensorBoard, Optuna, etc), creating standard directory structure (e.g. `notebooks/`, `models/`, `data/` etc), selecting the Python interpreter and installing common VS Code extensions. They also provide a `.gitignore`, `README.md`, license and a notebook or Python module to test and verify the environment.

## 3. Standalone usage

The images can also be used directly with Docker, without VS Code Dev Containers. Two common workflows are described below.

### 3.1. JupyterLab

All seven images include JupyterLab. Start a container with the port exposed, then open the printed URL in a browser.

**CPU images:**
```bash
docker run --rm -it \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-cpu:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

**NVIDIA GPU images** (add `--gpus all`):
```bash
docker run --rm -it \
  --gpus all \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-nvidia:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

Once running, copy the `http://127.0.0.1:8888/lab?token=...` URL from the terminal output and open it in your browser. Replace `datascience-cpu` / `datascience-nvidia` with the image name for whichever environment you need.

> **Persistent storage:** The `docker run` commands above include `-v $(pwd):/workspace`, which bind-mounts your current host directory into `/workspace` inside the container. Files written there are saved on your host and survive container removal (`--rm`). Run the `docker run` command from whichever directory you want to work in.


### 3.2. VS Code: attach to running container

This gives a full VS Code experience inside the container with no extra software needed beyond the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

**1. Start the container** (keep it running with an interactive shell):

```bash
# CPU
docker run --rm -it \
  -v $(pwd):/workspace \
  gperdrizet/datascience-cpu:latest \
  /bin/bash

# NVIDIA GPU (add --gpus all)
docker run --rm -it \
  --gpus all \
  -v $(pwd):/workspace \
  gperdrizet/datascience-nvidia:latest \
  /bin/bash
```

**2. Attach VS Code** to the running container:
- Open the Command Palette (`Ctrl+Shift+P`)
- Run **Dev Containers: Attach to Running Container...**
- Select the container from the list

VS Code opens a new window connected to the container. Your mounted volume is available at `/workspace`. Any extensions you install are persisted in the container for the duration of the session.

## 4. Container summaries

- 4.1. datascience-nvidia
- 4.2. datascience-cpu
- 4.3. datascience-mac
- 4.4. deeplearning-nvidia
- 4.5. deeplearning-cpu
- 4.6. deeplearning-mac
- 4.7. llms-nvidia
- 4.8. llms-cpu
- 4.9. llms-mac

### 4.1. datascience-nvidia

Lightweight data science environment for intro Python and ML courses, with NVIDIA GPU acceleration via CuPy.

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.8.1-runtime-ubuntu24.04` |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | CUDA-capable NVIDIA GPU |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna, cupy 13.6.0 (custom wheel, sm_60-sm_100)

**DockerHub:** [`gperdrizet/datascience-nvidia:latest`](https://hub.docker.com/repository/docker/gperdrizet/datascience-nvidia/general)

### 4.2. datascience-cpu

Lightweight data science environment for intro Python and ML courses, CPU-only.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| Python | 3.12 |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna

**DockerHub:** [`gperdrizet/datascience-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/datascience-cpu/general)

### 4.3. datascience-mac

Lightweight data science environment for Apple Silicon (M1/M2/M3) Macs. Built as a native `linux/arm64` image; Docker Desktop on Mac runs it without emulation.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| Python | 3.12 |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna

**Note:** GPU/Metal passthrough is not supported in Docker on macOS. This image provides CPU-only computation with native ARM64 performance.

**DockerHub:** [`gperdrizet/datascience-mac:latest`](https://hub.docker.com/repository/docker/gperdrizet/datascience-mac/general)

### 4.4. deeplearning-nvidia

Full-featured deep learning environment with NVIDIA GPU support.

| Component | Version |
|-----------|---------|
| Base Image | `nvcr.io/nvidia/tensorflow:25.02-tf2-py3` |
| TensorFlow | 2.17 |
| PyTorch | 2.11.0 (custom wheel) |
| CuPy | 13.6.0 (custom wheel) |
| Keras | 3.x |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | Pascal - Blackwell (sm_60 - sm_100) |

**Custom wheels:** PyTorch and CuPy are built from source with wide GPU architecture support. Pre-built wheels are downloaded from GitHub Releases during image build. See [Building custom wheels](#55-building-custom-wheels) if you need to rebuild.

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, jupyterlab, keras_tuner, optuna, tensorboard

**DockerHub:** [`gperdrizet/deeplearning-nvidia:latest`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-nvidia/general)

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer)

### 4.5. deeplearning-cpu

Full-featured deep learning environment for CPU-only systems.

| Component | Version |
|-----------|---------|
| Base Image | `python:3.12-slim` |
| TensorFlow | 2.x (latest via pip) |
| PyTorch | Latest CPU (via pip) |
| Python | 3.12 |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, jupyterlab, keras_tuner, optuna, tensorboard

**DockerHub:** [`gperdrizet/deeplearning-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-cpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer)

### 4.6. deeplearning-mac

Full-featured deep learning environment for Apple Silicon (M1/M2/M3) Macs. Built as a native `linux/arm64` image — no Rosetta emulation. GPU acceleration is not available inside Docker on macOS.

| Component | Version |
|-----------|----------|
| Base Image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| TensorFlow | 2.17 |
| Keras | 3.x |
| PyTorch | Latest (CPU, ARM64) |
| Python | 3.12 |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, jupyterlab, keras_tuner, optuna, tensorboard

**DockerHub:** [`gperdrizet/deeplearning-mac:latest`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-mac/general)

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer)

### 4.7. llms-nvidia

LLM application development environment with NVIDIA GPU support. Includes LangChain, LlamaIndex, Hugging Face Transformers, and API clients.

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04` |
| PyTorch | 2.11.0 (custom wheel) |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | Pascal - Blackwell (sm_60 - sm_100) |

**Custom PyTorch build:** PyTorch is built from source with wide GPU architecture support. The pre-built wheel is downloaded from GitHub Releases during image build. See [Building custom wheels](#55-building-custom-wheels) if you need to rebuild.

**LLM frameworks:** langchain, llama-index, transformers, smolagents

**API clients:** openai, anthropic, ollama

**Other packages:** chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-nvidia:latest`](https://hub.docker.com/repository/docker/gperdrizet/llms-nvidia/general)

**Devcontainer repository:** [`github.com/gperdrizet/llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer)

### 4.8. llms-cpu

Lightweight LLM application development environment for CPU-only systems.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| PyTorch | Latest CPU (via pip) |
| Python | 3.12 |

**LLM frameworks:** langchain, llama-index, transformers, smolagents

**API clients:** openai, anthropic, ollama

**Other packages:** chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/llms-cpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer)

### 4.9. llms-mac

Lightweight LLM application development environment for Apple Silicon (M1/M2/M3) Macs. Built as a native `linux/arm64` image — no Rosetta emulation. GPU acceleration is not available inside Docker on macOS.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| PyTorch | Latest (CPU, ARM64) |
| Python | 3.12 |

**LLM frameworks:** langchain, llama-index, transformers, smolagents

**API clients:** openai, anthropic, ollama

**Other packages:** chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-mac:latest`](https://hub.docker.com/repository/docker/gperdrizet/llms-mac/general)

**Devcontainer repository:** [`github.com/gperdrizet/llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer)

## 5. Development

### 5.1. Releasing a new version

1. Make changes, commit, and push to `main` as normal
2. When ready to release, go to **GitHub Actions -> CI -> Run workflow**, enter the version number (e.g. `4.1.0`), and click **Run workflow**

The pipeline runs automatically:

1. **Build:** all seven images are built with the specified version (including linux/arm64 via QEMU)
2. **Test:** CPU, NVIDIA, and Mac image tests run in parallel
3. **Approve:** pipeline pauses; a notification is sent for manual approval
4. **Push:** on approval, images are pushed to DockerHub and DockerHub READMEs are updated
5. **Tag:** a git tag (`vx.x.x`) and GitHub release are created automatically
6. **Sync:** a dispatch event is sent to `datascience-devcontainer`, `deeplearning-devcontainer` and `llms-devcontainer`, which each create a matching version tag and GitHub release

Git tags are only created after a successful, approved push, so a tag always corresponds to a verified image on DockerHub.

### 5.2. Makefile reference

These commands are useful for local development and testing. The CI/CD pipeline calls the same targets automatically during a release.

#### Build commands

| Command | Description |
|---------|-------------|
| `make build-deeplearning-nvidia` | Build deeplearning NVIDIA image |
| `make build-deeplearning-cpu` | Build deeplearning CPU image |
| `make build-deeplearning-mac` | Build deeplearning Mac (linux/arm64) image |
| `make build-deeplearning` | Build all three deeplearning images |
| `make build-llms-nvidia` | Build llms NVIDIA image |
| `make build-llms-cpu` | Build llms CPU image |
| `make build-llms-mac` | Build llms Mac (linux/arm64) image |
| `make build-llms` | Build all three llms images |
| `make build-datascience-nvidia` | Build datascience NVIDIA image |
| `make build-datascience-cpu` | Build datascience CPU image |
| `make build-datascience-mac` | Build datascience Mac (linux/arm64) image |
| `make build-datascience` | Build all three datascience images |
| `make build-all` | Build all images |

#### Test commands

| Command | Description |
|---------|-------------|
| `make test-deeplearning-cpu` | Test deeplearning CPU image |
| `make test-deeplearning-nvidia` | Test deeplearning NVIDIA image |
| `make test-deeplearning-mac` | Test deeplearning Mac image |
| `make test-llms-cpu` | Test llms CPU image |
| `make test-llms-nvidia` | Test llms NVIDIA image |
| `make test-llms-mac` | Test llms Mac image |
| `make test-datascience-cpu` | Test datascience CPU image |
| `make test-datascience-nvidia` | Test datascience NVIDIA image |
| `make test-datascience-mac` | Test datascience Mac image |
| `make test-cpu` | Test all CPU images |
| `make test-nvidia` | Test all NVIDIA images |
| `make test-mac` | Test Mac image |
| `make test-all` | Test all images |

Test scripts are in `tests/` and can also be run directly, with an optional image tag argument:

```bash
bash tests/test-deeplearning-cpu.sh gperdrizet/deeplearning-cpu:4.1.0
```

#### Push commands

| Command | Description |
|---------|-------------|
| `make push-deeplearning-nvidia` | Push deeplearning NVIDIA image |
| `make push-deeplearning-cpu` | Push deeplearning CPU image |
| `make push-deeplearning-mac` | Push deeplearning Mac image |
| `make push-deeplearning` | Push all three deeplearning images |
| `make push-llms-nvidia` | Push llms NVIDIA image |
| `make push-llms-cpu` | Push llms CPU image |
| `make push-llms-mac` | Push llms Mac image |
| `make push-llms` | Push all three llms images |
| `make push-datascience-nvidia` | Push datascience NVIDIA image |
| `make push-datascience-cpu` | Push datascience CPU image |
| `make push-datascience-mac` | Push datascience Mac image |
| `make push-datascience` | Push all three datascience images |
| `make push-all` | Push all images |

#### DockerHub README commands

Requires a `.env` file in the project root:

```bash
DOCKERHUB_USERNAME=gperdrizet
DOCKERHUB_TOKEN=your-dockerhub-pat
```

| Command | Description |
|---------|-------------|
| `make update-readme-deeplearning-nvidia` | Update deeplearning-nvidia DockerHub README |
| `make update-readme-deeplearning-cpu` | Update deeplearning-cpu DockerHub README |
| `make update-readme-deeplearning-mac` | Update deeplearning-mac DockerHub README |
| `make update-readme-llms-nvidia` | Update llms-nvidia DockerHub README |
| `make update-readme-llms-cpu` | Update llms-cpu DockerHub README |
| `make update-readme-llms-mac` | Update llms-mac DockerHub README |
| `make update-readme-datascience-nvidia` | Update datascience-nvidia DockerHub README |
| `make update-readme-datascience-cpu` | Update datascience-cpu DockerHub README |
| `make update-readme-datascience-mac` | Update datascience-mac DockerHub README |
| `make update-readme-all` | Update all DockerHub READMEs |

### 5.3. CI/CD infrastructure

#### GitHub Actions secrets

Set in GitHub repo Settings -> Secrets -> Actions:

| Secret | Used for |
|--------|----------|
| `DOCKERHUB_USERNAME` | DockerHub login |
| `DOCKERHUB_TOKEN` | DockerHub PAT (Read, Write & Delete) |
| `GH_DISPATCH_TOKEN` | GitHub fine-grained PAT to push tags to this repo and trigger devcontainer repo syncs. Requires Contents: read/write on `docker-images`, `datascience-devcontainer`, `deeplearning-devcontainer`, and `llms-devcontainer`. |

#### Self-hosted runner

The runner is installed as a systemd service on the GPU host:

```bash
sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status
```

It polls GitHub via long-polling HTTPS; no inbound ports are required. Jobs are rejected unless `github.repository_owner == 'gperdrizet'`.

### 5.4. Building linux/ARM64 for macOS

The `datascience-mac` image needs ARM64 emulation via Docker's buildx. You must create a builder before building the image:

```
# Create a brand new builder utilizing the docker-container driver
docker buildx create --name mybuilder --driver docker-container --use

# Boot and inspect the builder to ensure "arm64" is listed under platforms
docker buildx inspect --bootstrap
```

#### Troubleshooting

Try resetting the emulator registration and removing, then recreating the builder:

```
# Reset the emulator
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

# Stop and remove the current builder
docker buildx rm mybuilder || true
```

### 5.5. Building custom wheels

The `deeplearning-nvidia` and `llms-nvidia` images use a custom PyTorch wheel, and `datascience-nvidia` uses a custom CuPy wheel. Both are built with wide GPU architecture support (Pascal through Blackwell, sm_60–sm_100). Pre-built wheels are hosted on GitHub Releases and downloaded during image build. Wheel builds are infrequent and done manually; once a wheel is on GitHub Releases, all subsequent image builds just download it — no compile step.

#### When to rebuild

Rebuild wheels when:
- Upgrading PyTorch or CuPy version
- Adding/removing GPU architecture support
- Updating the CUDA version in a base image

#### PyTorch wheel (deeplearning-nvidia + llms-nvidia)

| Container | Python | CUDA | Wheel name |
|-----------|--------|------|------------|
| deeplearning-nvidia | 3.12 | 12.8 | `torch-X.Y.Z-cp312-cp312-linux_x86_64.whl` |
| llms-nvidia | 3.12 | 12.8 | same wheel (reused from GitHub Releases) |

**Build commands:**

| Command | Description |
|---------|-------------|
| `make wheel-deeplearning-nvidia` | Build PyTorch wheel (Python 3.12, CUDA 12.8) |
| `make extract-wheel-deeplearning-nvidia` | Extract wheel from builder container |

**Build configuration** — override defaults via environment variables:

```bash
make wheel-deeplearning-nvidia PYTORCH_VERSION=2.12.0
make wheel-deeplearning-nvidia MAX_JOBS=8
make wheel-deeplearning-nvidia CUDA_ARCH_LIST="7.0;7.5;8.0;8.6"
```

**Full workflow:**

```bash
# 1. Build the wheel (takes 3-4 hours)
make wheel-deeplearning-nvidia

# 2. Extract wheel to ./wheels/
make extract-wheel-deeplearning-nvidia

# 3. Upload to GitHub Releases
gh release create pytorch-2.11.0-cu128-cp312 \
  ./wheels/torch-2.11.0-cp312-cp312-linux_x86_64.whl \
  --title "PyTorch 2.11.0 CUDA 12.8 (Pascal-Blackwell)" \
  --notes "Custom PyTorch wheel with sm_60-sm_100 support"

# 4. Update WHEEL_URL in deeplearning-nvidia/Dockerfile and llms-nvidia/Dockerfile, then rebuild via CI
```

#### CuPy wheel (datascience-nvidia)

| Container | Python | CUDA | Wheel name |
|-----------|--------|------|------------|
| datascience-nvidia | 3.12 | 12.8 | `cupy-X.Y.Z-cp312-cp312-linux_x86_64.whl` |

**Build commands:**

| Command | Description |
|---------|-------------|
| `make wheel-datascience-nvidia` | Build CuPy wheel (Python 3.12, CUDA 12.8) |
| `make extract-wheel-datascience-nvidia` | Extract wheel from builder container |

**Build configuration** — override defaults via environment variables:

```bash
make wheel-datascience-nvidia CUPY_VERSION=13.7.0
```

**Full workflow:**

```bash
# 1. Build the wheel (~1 hour)
make wheel-datascience-nvidia

# 2. Extract wheel to ./wheels/
make extract-wheel-datascience-nvidia

# 3. Upload to GitHub Releases
gh release create cupy-13.6.0-cu128-cp312 \
  ./wheels/cupy-13.6.0-cp312-cp312-linux_x86_64.whl \
  --title "CuPy 13.6.0 CUDA 12.8 (Pascal-Blackwell)" \
  --notes "Custom CuPy wheel with sm_60-sm_100 support"

# 4. Update WHEEL_URL in datascience-nvidia/Dockerfile, then rebuild via CI
```

## 6. License

The Dockerfiles, scripts, and documentation in this repository are licensed under the [MIT License](LICENSE).

Built images incorporate third-party base images with their own terms. By pulling or running an image you also accept the applicable upstream licenses:

| Base image | License |
|---|---|
| `python:3.12-slim` | [Python Software Foundation License](https://docs.python.org/3/license.html) |
| `nvcr.io/nvidia/tensorflow:25.02-tf2-py3` | [NVIDIA Deep Learning Container License](https://developer.nvidia.com/deep-learning-container-license) |
| `nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04` | [NVIDIA CUDA EULA](https://docs.nvidia.com/cuda/eula/) |
| `nvidia/cuda:12.8.1-runtime-ubuntu24.04` | [NVIDIA CUDA EULA](https://docs.nvidia.com/cuda/eula/) |
