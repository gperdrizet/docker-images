# Usage

## Requirements

- **GPU images:** Docker with NVIDIA GPU support and host driver >= 570.x (required for CUDA 12.8)
- **CPU images:** Docker

!!! note "CUDA version"
    GPU images use CUDA 12.8, supporting Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200). CUDA 12.x is the last series to support Pascal; [CUDA 13.0 removed Pascal, Maxwell, and Volta support entirely](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html).

## Devcontainer repositories

The recommended way to use these images. Each devcontainer repo wraps an image with VS Code configuration, a standard project layout, common extensions, and an environment verification notebook. To start: click **Use this template** on the repo, clone it, then open it in VS Code — the container starts automatically.

| Repo | Use case |
|------|----------|
| [`datascience-devcontainer`](https://github.com/gperdrizet/datascience-devcontainer) | Intro Python and ML |
| [`deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer) | TensorFlow + PyTorch |
| [`llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer) | LLM application development |
| [`kaggle-devcontainer`](https://github.com/gperdrizet/kaggle-devcontainer) | Kaggle competitions |

See each repo's README for full setup instructions, hardware requirements, and environment details.

## Standalone usage

The images can also be used directly with Docker, without VS Code Dev Containers.

### JupyterLab

All images include JupyterLab. Start a container with the port exposed, then open the printed URL in a browser.

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

Copy the `http://127.0.0.1:8888/lab?token=...` URL from the terminal output and open it in a browser. Replace `datascience-cpu` / `datascience-nvidia` with whichever image you need.

!!! tip "Persistent storage"
    The `-v $(pwd):/workspace` flag bind-mounts your current directory into `/workspace` inside the container. Files written there survive container removal (`--rm`). Run the command from whichever directory you want to work in.

### VS Code: attach to running container

This gives a full VS Code experience inside the container with no extra software beyond the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

**1. Start the container** (keep it running with an interactive shell):

```bash
# CPU
docker run --rm -it \
  -v $(pwd):/workspace \
  gperdrizet/datascience-cpu:latest \
  /bin/bash

# NVIDIA GPU
docker run --rm -it \
  --gpus all \
  -v $(pwd):/workspace \
  gperdrizet/datascience-nvidia:latest \
  /bin/bash
```

**2. Attach VS Code:**

- Open the Command Palette (`Ctrl+Shift+P`)
- Run **Dev Containers: Attach to Running Container...**
- Select the container from the list

Your mounted volume is available at `/workspace`. Extensions you install persist for the duration of the session.
