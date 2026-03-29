# Deep learning GPU development environment

A ready-to-use deep learning environment with NVIDIA GPU support for VS Code. Includes both **PyTorch** and **TensorFlow** frameworks. Designed for cross-platform support and wide GPU compatibility.

**Base image**: [NVIDIA TensorFlow 25.02](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/tensorflow)

> **Note:** This container is designed to be used as part of a VS Code Dev Container environment, not run directly. See the [full environment setup on GitHub](https://github.com/gperdrizet/deeplearning-devcontainer) for devcontainer configuration and usage instructions.

> **CUDA version note:** This image uses CUDA 12.8, which supports GPU architectures from Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200). CUDA 12.x is the last series to support Pascal — [CUDA 13.0 removed Pascal, Maxwell, and Volta support entirely](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html). CUDA 12.8 requires host driver ≥ 570.x on Linux. Note: 25.02 is the final NVIDIA TensorFlow NGC container release.

## Features

- **Dual Framework Support** – Both TensorFlow 2.17 and PyTorch 2.11 pre-installed and GPU-ready
- **NVIDIA GPU Acceleration** – Built on NVIDIA's official TensorFlow container with CUDA 12.8 and Blackwell support
- **VS Code Dev Container Ready** – Pre-configured `vscode` user for seamless devcontainer integration

## Included software

| Component | Version |
|-----------|---------|
| Base Image | `nvcr.io/nvidia/tensorflow:25.02-tf2-py3` |
| TensorFlow | 2.17 |
| Keras | 3.x |
| PyTorch | 2.11 (custom build, CUDA 12.8) |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | Pascal through Blackwell (sm_60 - sm_100) |

### Additional Python packages
- `matplotlib` - Data visualization
- `seaborn` - Statistical data visualization
- `keras_tuner` - Hyperparameter tuning for Keras
- `optuna` - General purpose hyperparameter optimization framework
- `ipywidgets` - Interactive widgets for Jupyter

## Usage with VS Code dev containers

This image is optimized for use with VS Code Dev Containers. The `vscode` user (UID 1000) is pre-configured with sudo access for a seamless development experience.

## Running directly with Docker

You can also run the container directly with Docker and launch a Jupyter server:

```bash
docker run --gpus all -p 8888:8888 -v $(pwd):/workspace gperdrizet/deeplearning-gpu:latest \
    jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --notebook-dir=/workspace \
    --NotebookApp.token=''
```

This will:
- Enable GPU access with `--gpus all`
- Map port 8888 for Jupyter access
- Mount your current directory to `/workspace` in the container
- Start a Jupyter notebook server accessible at `http://localhost:8888`
- Disable token authentication (suitable for LAN-only environments)

> **Security Note:** Only disable authentication on trusted networks. For public or untrusted networks, remove `--NotebookApp.token=''` to require token authentication.


## Requirements

- Docker with NVIDIA GPU support
- NVIDIA GPU with compatible drivers

## License

See the [GitHub repository](https://github.com/gperdrizet/deeplearning-devcontainer) for license information.
