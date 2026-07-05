# Docker Images

[![CI](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml/badge.svg)](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml)
[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![CUDA](https://img.shields.io/badge/CUDA-12.8-76B900?logo=nvidia&logoColor=white)](https://developer.nvidia.com/cuda-toolkit)
[![JupyterLab](https://img.shields.io/badge/JupyterLab-3.6.8-F37626?logo=jupyter&logoColor=white)](https://jupyterlab.readthedocs.io/)
[![NumPy](https://img.shields.io/badge/NumPy-2.0.2-013243?logo=numpy&logoColor=white)](https://numpy.org/)
[![pandas](https://img.shields.io/badge/pandas-2.3.3-150458?logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![Matplotlib](https://img.shields.io/badge/Matplotlib-3.10.0-11557C?logo=matplotlib&logoColor=white)](https://matplotlib.org/)
[![scikit-learn](https://img.shields.io/badge/scikit--learn-1.6.1-F7931E?logo=scikitlearn&logoColor=white)](https://scikit-learn.org/)
[![XGBoost](https://img.shields.io/badge/XGBoost-3.2.0-189AB4)](https://xgboost.readthedocs.io/)
[![LightGBM](https://img.shields.io/badge/LightGBM-4.6.0-2980B9)](https://lightgbm.readthedocs.io/)
[![Optuna](https://img.shields.io/badge/Optuna-4.9.0-3EA7DC)](https://optuna.org/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.11.0-EE4C2C?logo=pytorch&logoColor=white)](https://pytorch.org/)
[![TensorFlow](https://img.shields.io/badge/TensorFlow-2.17-FF6F00?logo=tensorflow&logoColor=white)](https://www.tensorflow.org/)
[![RAPIDS](https://img.shields.io/badge/RAPIDS-26.2-7400FF?logo=nvidia&logoColor=white)](https://rapids.ai/)
[![Transformers](https://img.shields.io/badge/🤗_Transformers-latest-FFD21E)](https://huggingface.co/docs/transformers)
[![🤗 Datasets](https://img.shields.io/badge/🤗_Datasets-5.0.0-FFD21E)](https://huggingface.co/docs/datasets)
[![LangChain](https://img.shields.io/badge/LangChain-latest-1C3C3C)](https://python.langchain.com/)

Twelve containerized AI/ML environments in four families — **datascience**, **deeplearning**, **llms**, and **kaggle** — each available for NVIDIA GPU, CPU, and Apple Silicon. Used via the devcontainer repos below, which add VS Code configuration and project scaffolding so setup is a single `git clone`.

<table>
  <thead>
    <tr>
      <th>Devcontainer repo</th>
      <th>Purpose</th>
      <th>Hardware</th>
      <th>Image</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/datascience-devcontainer"><code>datascience-devcontainer</code></a></td>
      <td rowspan="3">Intro data science</td>
      <td>NVIDIA GPU</td>
      <td><code>datascience-nvidia</code></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>datascience-cpu</code></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>datascience-mac</code></td>
    </tr>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/deeplearning-devcontainer"><code>deeplearning-devcontainer</code></a></td>
      <td rowspan="3">Deep learning (TensorFlow + PyTorch)</td>
      <td>NVIDIA GPU</td>
      <td><code>deeplearning-nvidia</code></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>deeplearning-cpu</code></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>deeplearning-mac</code></td>
    </tr>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/llms-devcontainer"><code>llms-devcontainer</code></a></td>
      <td rowspan="3">LLM application development</td>
      <td>NVIDIA GPU</td>
      <td><code>llms-nvidia</code></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>llms-cpu</code></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>llms-mac</code></td>
    </tr>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/kaggle-devcontainer"><code>kaggle-devcontainer</code></a></td>
      <td rowspan="3">Kaggle competitions</td>
      <td>NVIDIA GPU</td>
      <td><code>kaggle-nvidia</code></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>kaggle-cpu</code></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>kaggle-mac</code></td>
    </tr>
  </tbody>
</table>

### Goals

1. **Eliminate setup friction**: clone a devcontainer repo, open in VS Code, done. No manual environment configuration.
2. **Wide hardware support**: GPU images cover Pascal through Blackwell; CPU fallbacks for machines without a GPU; native `linux/arm64` for Apple Silicon.
3. **Low barrier to entry**: any machine works. A 16GB P100 can be had on eBay for ~$90 — enough to train deep learning models and host LLMs without cloud compute or proprietary APIs.
4. **Standardized environments**: the same software stack across all platforms, reducing troubleshooting burden and making community support easier.

## Contents

- [1. Usage](#1-usage)
- [4. Development](#4-development)
- [5. Container summaries](#5-container-summaries)
- [6. License](#6-license)

## 1. Usage

How to get an environment running, whether through a devcontainer repo or by running an image directly with Docker.

- [1.1. Requirements](#11-requirements)
- [1.2. Devcontainer repositories](#12-devcontainer-repositories)
- [1.3. Standalone usage](#13-standalone-usage)
  - [1.3.1. JupyterLab](#131-jupyterlab)
  - [1.3.2. VS Code: attach to running container](#132-vs-code-attach-to-running-container)

### 1.1. Requirements

- **GPU images:** Docker with NVIDIA GPU support and host driver >= 570.x (required for CUDA 12.8)
- **CPU images:** Docker

> **CUDA version note:** GPU images use CUDA 12.8, supporting Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200). CUDA 12.x is the last series to support Pascal; [CUDA 13.0 removed Pascal, Maxwell, and Volta support entirely](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html).

The images can also be used directly with Docker, without VS Code Dev Containers. Two common workflows are described below.

### 1.2. Devcontainer repositories

The recommended way to use these images. Each devcontainer repo wraps an image with VS Code configuration, a standard project layout, common extensions, and an environment verification notebook. To start: click **Use this template** on the repo, clone it, then open it in VS Code — the container starts automatically.

| Repo | Use case |
|------|----------|
| [`datascience-devcontainer`](https://github.com/gperdrizet/datascience-devcontainer) | Intro Python and ML |
| [`deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer) | TensorFlow + PyTorch |
| [`llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer) | LLM application development |
| [`kaggle-devcontainer`](https://github.com/gperdrizet/kaggle-devcontainer) | Kaggle competitions |

See each repo's README for full setup instructions, hardware requirements, and environment details.

### 1.3. Standalone usage

#### 1.3.1. JupyterLab

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


#### 1.3.2. VS Code: attach to running container

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

## 4. Development

Reference for building, testing, and releasing images — including the CI/CD pipeline, Makefile targets, and how to rebuild custom wheels.

- [4.1. Design rationale](#41-design-rationale)
- [4.2. Releasing a new version](#42-releasing-a-new-version)
- [4.3. Makefile reference](#43-makefile-reference)
- [4.4. CI/CD infrastructure](#44-cicd-infrastructure)
- [4.5. Building linux/ARM64 for macOS](#45-building-linuxarm64-for-macos)
- [4.6. Building custom wheels](#46-building-custom-wheels)

### 4.1. Design rationale

The `datascience-*` images provide a lightweight environment for intro Python and ML classes: numpy, pandas, scikit-learn, xgboost, matplotlib, seaborn, plotly, jupyterlab, optuna, and python-dotenv. The `datascience-mac`, `deeplearning-mac`, and `llms-mac` variants target Apple Silicon (M1/M2/M3) and are built as native `linux/arm64` images.

The `deeplearning-nvidia` image is based on NVIDIA's official NGC TensorFlow container, which provides a fully validated CUDA + cuDNN + TensorFlow stack that supports Pascal (sm_60) out of the box. PyTorch is then added via a custom-built wheel, as official PyTorch CUDA 12.x wheels dropped Pascal support. The `llms-nvidia` image follows the same custom-wheel approach but on a minimal `nvidia/cuda` base, since it doesn't need TensorFlow. This combination ensures all NVIDIA images work on Pascal through Blackwell hardware with no changes to student workflow. CPU images use `python:3.12-slim` with the same Python packages, providing a consistent environment for CPU-only machines.

The `kaggle-*` images mirror the Kaggle notebook submission environment: package versions are pinned to match the pip freeze of a Kaggle notebook session (Python 3.12), so code developed locally behaves the same when submitted to competitions. The `kaggle-nvidia` image additionally ships the RAPIDS stack (cuDF/cuML/CuPy) as found in Kaggle GPU sessions, and uses a custom PyTorch 2.10.0 wheel with Pascal support — notably, Kaggle ships the stock cu128 wheel, which has no Pascal kernels, so torch on Kaggle's own P100s fails with `no kernel image is available`. Same torch version, but it actually works on P100/GTX 10xx hardware.

### 4.2. Releasing a new version

1. Make changes, commit, and push to `main` as normal
2. When ready to release, go to **GitHub Actions -> CI -> Run workflow**, enter the version number (e.g. `4.1.0`), and click **Run workflow**

The pipeline runs automatically:

1. **Build:** all twelve images are built with the specified version (including linux/arm64 via QEMU)
2. **Test:** CPU, NVIDIA, and Mac image tests run in parallel
3. **Approve:** pipeline pauses; a notification is sent for manual approval
4. **Push:** on approval, images are pushed to DockerHub and DockerHub READMEs are updated
5. **Tag:** a git tag (`vx.x.x`) and GitHub release are created automatically
6. **Sync:** a dispatch event is sent to `datascience-devcontainer`, `deeplearning-devcontainer`, `llms-devcontainer` and `kaggle-devcontainer`, which each create a matching version tag and GitHub release

Git tags are only created after a successful, approved push, so a tag always corresponds to a verified image on DockerHub.

### 4.3. Makefile reference

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
| `make build-kaggle-nvidia` | Build kaggle NVIDIA image |
| `make build-kaggle-cpu` | Build kaggle CPU image |
| `make build-kaggle-mac` | Build kaggle Mac (linux/arm64) image |
| `make build-kaggle` | Build all three kaggle images |
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
| `make test-kaggle-cpu` | Test kaggle CPU image |
| `make test-kaggle-nvidia` | Test kaggle NVIDIA image |
| `make test-kaggle-mac` | Test kaggle Mac image |
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
| `make push-kaggle-nvidia` | Push kaggle NVIDIA image |
| `make push-kaggle-cpu` | Push kaggle CPU image |
| `make push-kaggle-mac` | Push kaggle Mac image |
| `make push-kaggle` | Push all three kaggle images |
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
| `make update-readme-kaggle-nvidia` | Update kaggle-nvidia DockerHub README |
| `make update-readme-kaggle-cpu` | Update kaggle-cpu DockerHub README |
| `make update-readme-kaggle-mac` | Update kaggle-mac DockerHub README |
| `make update-readme-all` | Update all DockerHub READMEs |

### 4.4. CI/CD infrastructure

#### GitHub Actions secrets

Set in GitHub repo Settings -> Secrets -> Actions:

| Secret | Used for |
|--------|----------|
| `DOCKERHUB_USERNAME` | DockerHub login |
| `DOCKERHUB_TOKEN` | DockerHub PAT (Read, Write & Delete) |
| `GH_DISPATCH_TOKEN` | GitHub fine-grained PAT to push tags to this repo and trigger devcontainer repo syncs. Requires Contents: read/write on `docker-images`, `datascience-devcontainer`, `deeplearning-devcontainer`, `llms-devcontainer`, and `kaggle-devcontainer`. |

#### Self-hosted runner

The runner is installed as a systemd service on the GPU host:

```bash
sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status
```

It polls GitHub via long-polling HTTPS; no inbound ports are required. Jobs are rejected unless `github.repository_owner == 'gperdrizet'`.

### 4.5. Building linux/ARM64 for macOS

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

### 4.6. Building custom wheels

The `deeplearning-nvidia`, `llms-nvidia`, and `kaggle-nvidia` images use custom PyTorch wheels, and `datascience-nvidia` uses a custom CuPy wheel. All are built with wide GPU architecture support (Pascal through Blackwell, sm_60–sm_100). Pre-built wheels are hosted on GitHub Releases and downloaded during image build. Wheel builds are infrequent and done manually; once a wheel is on GitHub Releases, all subsequent image builds just download it, no compile step.

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
| kaggle-nvidia | 3.12 | 12.8 | `torch-2.10.0-cp312-cp312-linux_x86_64.whl` (version pinned to match Kaggle) |

**Build commands:**

| Command | Description |
|---------|-------------|
| `make wheel-deeplearning-nvidia` | Build PyTorch wheel (Python 3.12, CUDA 12.8) |
| `make extract-wheel-deeplearning-nvidia` | Extract wheel from builder container |

**Build configuration**: override defaults via environment variables:

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

**Build configuration**: override defaults via environment variables:

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

## 5. Container summaries

Per-image reference: base image, key package versions, and DockerHub links for all twelve containers.

- [5.1. datascience-nvidia](#51-datascience-nvidia)
- [5.2. datascience-cpu](#52-datascience-cpu)
- [5.3. datascience-mac](#53-datascience-mac)
- [5.4. deeplearning-nvidia](#54-deeplearning-nvidia)
- [5.5. deeplearning-cpu](#55-deeplearning-cpu)
- [5.6. deeplearning-mac](#56-deeplearning-mac)
- [5.7. llms-nvidia](#57-llms-nvidia)
- [5.8. llms-cpu](#58-llms-cpu)
- [5.9. llms-mac](#59-llms-mac)
- [5.10. kaggle-nvidia](#510-kaggle-nvidia)
- [5.11. kaggle-cpu](#511-kaggle-cpu)
- [5.12. kaggle-mac](#512-kaggle-mac)

### 5.1. datascience-nvidia

Lightweight data science environment for intro Python and ML courses, with NVIDIA GPU acceleration via CuPy.

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.8.1-runtime-ubuntu24.04` |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | CUDA-capable NVIDIA GPU |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna, python-dotenv, cupy 13.6.0 (custom wheel, sm_60-sm_100)

**DockerHub:** [`gperdrizet/datascience-nvidia:latest`](https://hub.docker.com/repository/docker/gperdrizet/datascience-nvidia/general)

### 5.2. datascience-cpu

Lightweight data science environment for intro Python and ML courses, CPU-only.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| Python | 3.12 |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna, python-dotenv

**DockerHub:** [`gperdrizet/datascience-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/datascience-cpu/general)

### 5.3. datascience-mac

Lightweight data science environment for Apple Silicon (M1/M2/M3) Macs. Built as a native `linux/arm64` image; Docker Desktop on Mac runs it without emulation.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| Python | 3.12 |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna, python-dotenv

**Note:** GPU/Metal passthrough is not supported in Docker on macOS. This image provides CPU-only computation with native ARM64 performance.

**DockerHub:** [`gperdrizet/datascience-mac:latest`](https://hub.docker.com/repository/docker/gperdrizet/datascience-mac/general)

### 5.4. deeplearning-nvidia

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

**Custom wheels:** PyTorch and CuPy are built from source with wide GPU architecture support. Pre-built wheels are downloaded from GitHub Releases during image build. See [Building custom wheels](#45-building-custom-wheels) if you need to rebuild.

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, plotly, jupyterlab, keras_tuner, optuna, tensorboard, python-dotenv

**DockerHub:** [`gperdrizet/deeplearning-nvidia:latest`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-nvidia/general)

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer)

### 5.5. deeplearning-cpu

Full-featured deep learning environment for CPU-only systems.

| Component | Version |
|-----------|---------|
| Base Image | `python:3.12-slim` |
| TensorFlow | 2.x (latest via pip) |
| PyTorch | Latest CPU (via pip) |
| Python | 3.12 |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, plotly, jupyterlab, keras_tuner, optuna, tensorboard, python-dotenv

**DockerHub:** [`gperdrizet/deeplearning-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-cpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer)

### 5.6. deeplearning-mac

Full-featured deep learning environment for Apple Silicon (M1/M2/M3) Macs. Built as a native `linux/arm64` image, no Rosetta emulation. GPU acceleration is not available inside Docker on macOS.

| Component | Version |
|-----------|----------|
| Base Image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| TensorFlow | 2.17 |
| Keras | 3.x |
| PyTorch | Latest (CPU, ARM64) |
| Python | 3.12 |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, plotly, jupyterlab, keras_tuner, optuna, tensorboard, python-dotenv

**DockerHub:** [`gperdrizet/deeplearning-mac:latest`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-mac/general)

**Devcontainer repository:** [`github.com/gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer)

### 5.7. llms-nvidia

LLM application development environment with NVIDIA GPU support. Includes LangChain, LlamaIndex, Hugging Face Transformers, and API clients.

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04` |
| PyTorch | 2.11.0 (custom wheel) |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | Pascal - Blackwell (sm_60 - sm_100) |

**Custom PyTorch build:** PyTorch is built from source with wide GPU architecture support. The pre-built wheel is downloaded from GitHub Releases during image build. See [Building custom wheels](#45-building-custom-wheels) if you need to rebuild.

**LLM frameworks:** langchain, llama-index, transformers, smolagents

**API clients:** openai, anthropic, ollama

**Other packages:** jupyterlab, ipykernel, ipywidgets, chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-nvidia:latest`](https://hub.docker.com/repository/docker/gperdrizet/llms-nvidia/general)

**Devcontainer repository:** [`github.com/gperdrizet/llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer)

### 5.8. llms-cpu

Lightweight LLM application development environment for CPU-only systems.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| PyTorch | Latest CPU (via pip) |
| Python | 3.12 |

**LLM frameworks:** langchain, llama-index, transformers, smolagents

**API clients:** openai, anthropic, ollama

**Other packages:** jupyterlab, ipykernel, ipywidgets, chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/llms-cpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer)

### 5.9. llms-mac

Lightweight LLM application development environment for Apple Silicon (M1/M2/M3) Macs. Built as a native `linux/arm64` image, no Rosetta emulation. GPU acceleration is not available inside Docker on macOS.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| PyTorch | Latest (CPU, ARM64) |
| Python | 3.12 |

**LLM frameworks:** langchain, llama-index, transformers, smolagents

**API clients:** openai, anthropic, ollama

**Other packages:** jupyterlab, ipykernel, ipywidgets, chromadb, sentence-transformers, gradio, accelerate, datasets, tiktoken

**DockerHub:** [`gperdrizet/llms-mac:latest`](https://hub.docker.com/repository/docker/gperdrizet/llms-mac/general)

**Devcontainer repository:** [`github.com/gperdrizet/llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer)

### 5.10. kaggle-nvidia

Mirror of the Kaggle notebook GPU environment. Package versions are pinned to match the pip freeze of a Kaggle GPU notebook session, so code developed here behaves the same when submitted to competitions. Uses a custom PyTorch 2.10.0 wheel with Pascal support (sm_60–sm_100) — same version Kaggle ships, but unlike Kaggle's stock cu128 wheel it actually works on P100/GTX 10xx hardware. Includes the RAPIDS stack (cuDF/cuML/CuPy) as found in Kaggle GPU sessions; note RAPIDS requires Volta (sm_70) or newer, on Kaggle and everywhere else.

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04` |
| CUDA | 12.8.1 |
| PyTorch | 2.10.0 (custom wheel, sm_60–sm_100) |
| TensorFlow | 2.20.0 |
| RAPIDS | cuDF 26.2.1, cuML 26.2.0, CuPy 14.0.1 |
| Python | 3.12 |

**ML packages:** scikit-learn 1.6.1, xgboost 3.2.0, lightgbm 4.6.0, catboost 1.2.10, transformers 5.0.0, keras 3.13.2

**Other packages:** numpy 2.0.2, pandas 2.3.3, polars, jupyterlab 3.6.8, optuna, shap, opencv, albumentations, kaggle, kagglehub

**DockerHub:** [`gperdrizet/kaggle-nvidia:latest`](https://hub.docker.com/repository/docker/gperdrizet/kaggle-nvidia/general)

**Devcontainer repository:** [`github.com/gperdrizet/kaggle-devcontainer`](https://github.com/gperdrizet/kaggle-devcontainer)

### 5.11. kaggle-cpu

Mirror of the Kaggle notebook CPU environment. Package versions are pinned to match the pip freeze of a Kaggle CPU notebook session. No GPU dependencies; works on any machine.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| PyTorch | 2.10.0 (CPU) |
| TensorFlow | 2.20.0 |
| Python | 3.12 |

**ML packages:** scikit-learn 1.6.1, xgboost 3.2.0, lightgbm 4.6.0, catboost 1.2.10, transformers 5.0.0, keras 3.13.2

**Other packages:** numpy 2.0.2, pandas 2.3.3, polars, jupyterlab 3.6.8, optuna, shap, opencv, albumentations, kaggle, kagglehub

**DockerHub:** [`gperdrizet/kaggle-cpu:latest`](https://hub.docker.com/repository/docker/gperdrizet/kaggle-cpu/general)

**Devcontainer repository:** [`github.com/gperdrizet/kaggle-devcontainer`](https://github.com/gperdrizet/kaggle-devcontainer)

### 5.12. kaggle-mac

Mirror of the Kaggle notebook CPU environment for Apple Silicon (M1/M2/M3) Macs. Built as a native `linux/arm64` image, no Rosetta emulation. GPU acceleration is not available inside Docker on macOS.

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| PyTorch | 2.10.0 (CPU, ARM64) |
| TensorFlow | 2.20.0 |
| Python | 3.12 |

**ML packages:** scikit-learn 1.6.1, xgboost 3.2.0, lightgbm 4.6.0, catboost 1.2.10, transformers 5.0.0, keras 3.13.2

**Other packages:** numpy 2.0.2, pandas 2.3.3, polars, jupyterlab 3.6.8, optuna, shap, opencv, albumentations, kaggle, kagglehub

**DockerHub:** [`gperdrizet/kaggle-mac:latest`](https://hub.docker.com/repository/docker/gperdrizet/kaggle-mac/general)

**Devcontainer repository:** [`github.com/gperdrizet/kaggle-devcontainer`](https://github.com/gperdrizet/kaggle-devcontainer)

## 6. License

The Dockerfiles, scripts, and documentation in this repository are licensed under the [MIT License](LICENSE).

Built images incorporate third-party base images with their own terms. By pulling or running an image you also accept the applicable upstream licenses:

| Base image | License |
|---|---|
| `python:3.12-slim` | [Python Software Foundation License](https://docs.python.org/3/license.html) |
| `nvcr.io/nvidia/tensorflow:25.02-tf2-py3` | [NVIDIA Deep Learning Container License](https://developer.nvidia.com/deep-learning-container-license) |
| `nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04` | [NVIDIA CUDA EULA](https://docs.nvidia.com/cuda/eula/) |
| `nvidia/cuda:12.8.1-runtime-ubuntu24.04` | [NVIDIA CUDA EULA](https://docs.nvidia.com/cuda/eula/) |
