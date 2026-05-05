# Docker Images

A collection of ready-to-use deep learning Docker images for VS Code Dev Containers, designed for AI/ML bootcamp students. GPU images are built with wide hardware compatibility (NVIDIA Pascal through Blackwell, sm_60-sm_100) so they work across diverse student hardware. All images include a pre-configured `vscode` user (UID 1000) with sudo access for seamless devcontainer integration.

> **CUDA version note:** GPU images use CUDA 12.8, supporting Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200). CUDA 12.x is the last series to support Pascal — [CUDA 13.0 removed Pascal, Maxwell, and Volta support entirely](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html). CUDA 12.8 requires host driver ≥ 570.x on Linux.

## Quick Start

```bash
# Build all images
make build-all

# Run all tests
make test-all

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

## CI/CD

Releases are automated via GitHub Actions using a self-hosted runner (required for GPU access and local network).

### Release workflow

```
git tag v4.1.0 && git push --tags
```

Pushing a version tag triggers the pipeline:

1. **Build** — all four images are built via `make build-all`
2. **Test** — CPU and GPU image tests run in parallel via `make test-cpu` and `make test-gpu`
3. **Approve** — pipeline pauses; a notification is sent for manual approval
4. **Push** — on approval, images are pushed to DockerHub and DockerHub READMEs are updated
5. **Sync** — a dispatch event is sent to `deeplearning-devcontainer` and `llms-devcontainer`, which each create a matching version tag and GitHub release

Workday commits to `main` do not trigger the pipeline — only version tags do.

### Running tests locally

```bash
make test-all        # all four images
make test-cpu        # deeplearning-cpu + llms-cpu
make test-gpu        # deeplearning-gpu + llms-gpu
make test-llms-cpu   # individual image
```

Test scripts are in `tests/` and can also be run directly:

```bash
bash tests/test-deeplearning-cpu.sh gperdrizet/deeplearning-cpu:4.0.0
```

### Required secrets

Set in GitHub → repo Settings → Secrets → Actions:

| Secret | Used for |
|--------|----------|
| `DOCKERHUB_USERNAME` | DockerHub login |
| `DOCKERHUB_TOKEN` | DockerHub PAT (Read, Write & Delete) |
| `GH_DISPATCH_TOKEN` | GitHub fine-grained PAT to trigger devcontainer repo syncs (Contents: read/write on both devcontainer repos) |

### Self-hosted runner

The runner is installed as a systemd service on the GPU host:

```bash
sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status
```

It polls GitHub via long-polling HTTPS — no inbound ports required. Jobs are rejected unless `github.repository_owner == 'gperdrizet'`.

---

## Makefile Commands

### Build Commands

| Command | Description |
|---------|-------------|
| `make build-deeplearning-gpu` | Build deeplearning GPU image |
| `make build-deeplearning-cpu` | Build deeplearning CPU image |
| `make build-deeplearning` | Build both deeplearning images |
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
| `make push-llms-gpu` | Push llms GPU image |
| `make push-llms-cpu` | Push llms CPU image |
| `make push-llms` | Push both llms images |
| `make push-all` | Push all images |

### Test Commands

| Command | Description |
|---------|-------------|
| `make test-deeplearning-cpu` | Test deeplearning CPU image |
| `make test-deeplearning-gpu` | Test deeplearning GPU image |
| `make test-llms-cpu` | Test llms CPU image |
| `make test-llms-gpu` | Test llms GPU image |
| `make test-cpu` | Test both CPU images |
| `make test-gpu` | Test both GPU images |
| `make test-all` | Test all images |

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
| `make update-readme-llms-gpu` | Update llms-gpu DockerHub README |
| `make update-readme-llms-cpu` | Update llms-cpu DockerHub README |
| `make update-readme-all` | Update all DockerHub READMEs |

## Container Summaries

1. deeplearning-gpu
2. deeplearning-cpu
3. llms-gpu
4. llms-cpu

### 1. deeplearning-gpu

Full-featured deep learning environment with NVIDIA GPU support.

| Component | Version |
|-----------|---------|
| Base Image | `nvcr.io/nvidia/tensorflow:25.02-tf2-py3` |
| TensorFlow | 2.17 |
| PyTorch | 2.11.0 (custom wheel) |
| Keras | 3.x |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | Pascal - Blackwell (sm_60 - sm_100) |

**Custom PyTorch Build:** PyTorch is built from source with wide GPU architecture support. The pre-built wheel is downloaded from GitHub Releases during image build. See [Rebuilding PyTorch Wheels](#rebuilding-pytorch-wheels) if you need to rebuild.

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, jupyterlab, keras_tuner, optuna, tensorboard

**DockerHub:** [`gperdrizet/deeplearning-gpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-gpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer)

---

### 2. deeplearning-cpu

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

---

### 3. llms-gpu

LLM application development environment with NVIDIA GPU support. Includes LangChain, LlamaIndex, Hugging Face Transformers, and API clients.

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04` |
| PyTorch | 2.11.0 (custom wheel) |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | Pascal - Blackwell (sm_60 - sm_100) |

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
| Base Image | `python:3.12-slim` |
| PyTorch | Latest CPU (via pip) |
| Python | 3.12 |

**LLM Frameworks:** langchain, llama-index, transformers, smolagents

**API Clients:** openai, anthropic, ollama

**Other packages:** chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/llms-cpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer)

---

## Requirements

- **GPU images:** Docker with NVIDIA GPU support and compatible drivers
- **CPU images:** Docker

## Rebuilding PyTorch Wheels

The `llms-gpu` and `deeplearning-gpu` images use custom-built PyTorch wheels with wide GPU architecture support (Pascal through Hopper). Pre-built wheels are hosted on GitHub Releases and downloaded during image build.

### Why Custom Wheels?

Standard PyTorch wheels only support recent GPU architectures. Our custom builds include `sm_60` through `sm_100` for compatibility with diverse student hardware, from GTX 1060 to RTX 5090/B200.

### When to Rebuild

Rebuild wheels when:
- Upgrading PyTorch version
- Adding/removing GPU architecture support
- Updating CUDA version in base image

### Build Commands

| Command | Description |
|---------|-------------|
| `make wheel-deeplearning-gpu` | Build PyTorch wheel (Python 3.12, CUDA 12.8) |
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
make wheel-deeplearning-gpu

# 2. Extract wheel to ./wheels/
make extract-wheel-deeplearning-gpu

# 3. Upload to GitHub Releases
gh release create pytorch-2.11.0-cu128-cp312 ./wheels/torch-2.11.0-cp312-cp312-linux_x86_64.whl \
  --title "PyTorch 2.11.0 CUDA 12.8 (Pascal-Blackwell)" \
  --notes "Custom PyTorch wheel with sm_60-sm_100 support"

# 4. Update WHEEL_URL in both Dockerfiles and rebuild
make build-all
```

### Wheel Specifications

| Container | Python | CUDA | Wheel Name |
|-----------|--------|------|------------|
| deeplearning-gpu | 3.12 | 12.8 | `torch-X.Y.Z-cp312-cp312-linux_x86_64.whl` |
| llms-gpu | 3.12 | 12.8 | same wheel (reused from GitHub Releases) |

## License

See individual container directories for license information.
