# Docker Images

[![CI](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml/badge.svg)](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml)
[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.11.0-EE4C2C?logo=pytorch&logoColor=white)](https://pytorch.org/)
[![TensorFlow](https://img.shields.io/badge/TensorFlow-2.17-FF6F00?logo=tensorflow&logoColor=white)](https://www.tensorflow.org/)
[![CUDA](https://img.shields.io/badge/CUDA-12.8-76B900?logo=nvidia&logoColor=white)](https://developer.nvidia.com/cuda-toolkit)
[![Transformers](https://img.shields.io/badge/🤗_Transformers-latest-FFD21E)](https://huggingface.co/docs/transformers)

[![Docker Pulls deeplearning-gpu](https://img.shields.io/docker/pulls/gperdrizet/deeplearning-gpu?label=deeplearning-gpu&logo=docker)](https://hub.docker.com/r/gperdrizet/deeplearning-gpu)
[![Docker Pulls deeplearning-cpu](https://img.shields.io/docker/pulls/gperdrizet/deeplearning-cpu?label=deeplearning-cpu&logo=docker)](https://hub.docker.com/r/gperdrizet/deeplearning-cpu)
[![Docker Pulls llms-gpu](https://img.shields.io/docker/pulls/gperdrizet/llms-gpu?label=llms-gpu&logo=docker)](https://hub.docker.com/r/gperdrizet/llms-gpu)
[![Docker Pulls llms-cpu](https://img.shields.io/docker/pulls/gperdrizet/llms-cpu?label=llms-cpu&logo=docker)](https://hub.docker.com/r/gperdrizet/llms-cpu)

A collection of ready-to-use Docker images for VS Code Dev Containers, designed for AI/ML bootcamp students. GPU images are built with wide hardware compatibility (NVIDIA Pascal through Blackwell, sm_60-sm_100) so they work across diverse student hardware. All images include a pre-configured `vscode` user (UID 1000) with sudo access for seamless devcontainer integration.

> **CUDA version note:** GPU images use CUDA 12.8, supporting Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200). CUDA 12.x is the last series to support Pascal; [CUDA 13.0 removed Pascal, Maxwell, and Volta support entirely](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html). CUDA 12.8 requires host driver >= 570.x on Linux.

## Releasing a new version

1. Make changes, commit, and push to `main` as normal
2. When ready to release, go to **GitHub Actions -> CI -> Run workflow**, enter the version number (e.g. `4.1.0`), and click **Run workflow**

The pipeline runs automatically:

1. **Build:** all four images are built with the specified version
2. **Test:** CPU and GPU image tests run in parallel
3. **Approve:** pipeline pauses; a notification is sent for manual approval
4. **Push:** on approval, images are pushed to DockerHub and DockerHub READMEs are updated
5. **Tag:** a git tag (`v4.1.0`) and GitHub release are created automatically
6. **Sync:** a dispatch event is sent to `deeplearning-devcontainer` and `llms-devcontainer`, which each create a matching version tag and GitHub release

Git tags are only created after a successful, approved push, so a tag always corresponds to a verified image on DockerHub.

## Container summaries

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

**Custom PyTorch build:** PyTorch is built from source with wide GPU architecture support. The pre-built wheel is downloaded from GitHub Releases during image build. See [Rebuilding PyTorch wheels](#rebuilding-pytorch-wheels) if you need to rebuild.

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

**Custom PyTorch build:** PyTorch is built from source with wide GPU architecture support. The pre-built wheel is downloaded from GitHub Releases during image build. See [Rebuilding PyTorch wheels](#rebuilding-pytorch-wheels) if you need to rebuild.

**LLM frameworks:** langchain, llama-index, transformers, smolagents

**API clients:** openai, anthropic, ollama

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

## Makefile reference

These commands are useful for local development and testing. The CI/CD pipeline calls the same targets automatically during a release.

### Build commands

| Command | Description |
|---------|-------------|
| `make build-deeplearning-gpu` | Build deeplearning GPU image |
| `make build-deeplearning-cpu` | Build deeplearning CPU image |
| `make build-deeplearning` | Build both deeplearning images |
| `make build-llms-gpu` | Build llms GPU image |
| `make build-llms-cpu` | Build llms CPU image |
| `make build-llms` | Build both llms images |
| `make build-all` | Build all images |

### Test commands

| Command | Description |
|---------|-------------|
| `make test-deeplearning-cpu` | Test deeplearning CPU image |
| `make test-deeplearning-gpu` | Test deeplearning GPU image |
| `make test-llms-cpu` | Test llms CPU image |
| `make test-llms-gpu` | Test llms GPU image |
| `make test-cpu` | Test both CPU images |
| `make test-gpu` | Test both GPU images |
| `make test-all` | Test all images |

Test scripts are in `tests/` and can also be run directly, with an optional image tag argument:

```bash
bash tests/test-deeplearning-cpu.sh gperdrizet/deeplearning-cpu:4.1.0
```

### Push commands

| Command | Description |
|---------|-------------|
| `make push-deeplearning-gpu` | Push deeplearning GPU image |
| `make push-deeplearning-cpu` | Push deeplearning CPU image |
| `make push-deeplearning` | Push both deeplearning images |
| `make push-llms-gpu` | Push llms GPU image |
| `make push-llms-cpu` | Push llms CPU image |
| `make push-llms` | Push both llms images |
| `make push-all` | Push all images |

### DockerHub README commands

Requires a `.env` file in the project root:

```bash
DOCKERHUB_USERNAME=gperdrizet
DOCKERHUB_TOKEN=your-dockerhub-pat
```

| Command | Description |
|---------|-------------|
| `make update-readme-deeplearning-gpu` | Update deeplearning-gpu DockerHub README |
| `make update-readme-deeplearning-cpu` | Update deeplearning-cpu DockerHub README |
| `make update-readme-llms-gpu` | Update llms-gpu DockerHub README |
| `make update-readme-llms-cpu` | Update llms-cpu DockerHub README |
| `make update-readme-all` | Update all DockerHub READMEs |

## CI/CD infrastructure

### GitHub Actions secrets

Set in GitHub repo Settings -> Secrets -> Actions:

| Secret | Used for |
|--------|----------|
| `DOCKERHUB_USERNAME` | DockerHub login |
| `DOCKERHUB_TOKEN` | DockerHub PAT (Read, Write & Delete) |
| `GH_DISPATCH_TOKEN` | GitHub fine-grained PAT to push tags to this repo and trigger devcontainer repo syncs. Requires Contents: read/write on `docker-images`, `deeplearning-devcontainer`, and `llms-devcontainer`. |

### Self-hosted runner

The runner is installed as a systemd service on the GPU host:

```bash
sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status
```

It polls GitHub via long-polling HTTPS; no inbound ports are required. Jobs are rejected unless `github.repository_owner == 'gperdrizet'`.

## Rebuilding PyTorch wheels

The `llms-gpu` and `deeplearning-gpu` images use custom-built PyTorch wheels with wide GPU architecture support (Pascal through Blackwell). Pre-built wheels are hosted on GitHub Releases and downloaded during image build.

### Why custom wheels?

Standard PyTorch wheels only support recent GPU architectures. Our custom builds include `sm_60` through `sm_100` for compatibility with diverse student hardware, from GTX 1060 to RTX 5090/B200.

### When to rebuild

Rebuild wheels when:
- Upgrading PyTorch version
- Adding/removing GPU architecture support
- Updating CUDA version in base image

### Build commands

| Command | Description |
|---------|-------------|
| `make wheel-deeplearning-gpu` | Build PyTorch wheel (Python 3.12, CUDA 12.8) |
| `make extract-wheel-deeplearning-gpu` | Extract wheel from builder container |

### Build configuration

Override defaults via environment variables:

```bash
# Custom PyTorch version
make wheel-deeplearning-gpu PYTORCH_VERSION=2.12.0

# Adjust build parallelism (default: 16)
make wheel-deeplearning-gpu MAX_JOBS=8

# Custom GPU architectures
make wheel-deeplearning-gpu CUDA_ARCH_LIST="7.0;7.5;8.0;8.6"
```

### Full workflow

```bash
# 1. Build the wheel (takes 3-4 hours)
make wheel-deeplearning-gpu

# 2. Extract wheel to ./wheels/
make extract-wheel-deeplearning-gpu

# 3. Upload to GitHub Releases
gh release create pytorch-2.11.0-cu128-cp312 ./wheels/torch-2.11.0-cp312-cp312-linux_x86_64.whl \
  --title "PyTorch 2.11.0 CUDA 12.8 (Pascal-Blackwell)" \
  --notes "Custom PyTorch wheel with sm_60-sm_100 support"

# 4. Update WHEEL_URL in both Dockerfiles and rebuild via CI
```

### Wheel specifications

| Container | Python | CUDA | Wheel Name |
|-----------|--------|------|------------|
| deeplearning-gpu | 3.12 | 12.8 | `torch-X.Y.Z-cp312-cp312-linux_x86_64.whl` |
| llms-gpu | 3.12 | 12.8 | same wheel (reused from GitHub Releases) |

## License

See individual container directories for license information.
