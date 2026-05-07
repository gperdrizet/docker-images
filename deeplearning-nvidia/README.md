# Deep learning GPU development environment

A ready-to-use deep learning environment with NVIDIA GPU support for VS Code. Includes both **PyTorch** and **TensorFlow** frameworks. Designed for cross-platform support and wide GPU compatibility.

**Base image**: [NVIDIA TensorFlow 25.02](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/tensorflow)

> **Note:** This container is designed to be used as part of a VS Code Dev Container environment, not run directly. See the [full environment setup on GitHub](https://github.com/gperdrizet/deeplearning-devcontainer) for devcontainer configuration and usage instructions.

> **CUDA version note:** This image uses CUDA 12.8, which supports GPU architectures from Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200). CUDA 12.x is the last series to support Pascal; [CUDA 13.0 removed Pascal, Maxwell, and Volta support entirely](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html). CUDA 12.8 requires host driver ≥ 570.x on Linux. Note: 25.02 is the final NVIDIA TensorFlow NGC container release.

## 1. Features

- **Dual framework support:** Both TensorFlow 2.17 and PyTorch 2.11 pre-installed and GPU-ready
- **NVIDIA GPU acceleration:** Built on NVIDIA's official TensorFlow container with CUDA 12.8 and Blackwell support
- **VS Code Dev Container ready:** Pre-configured `vscode` user for seamless devcontainer integration

## 2. Included software

| Component | Version |
|-----------|---------|
| Base Image | `nvcr.io/nvidia/tensorflow:25.02-tf2-py3` |
| TensorFlow | 2.17 |
| Keras | 3.x |
| PyTorch | 2.11 (custom build, CUDA 12.8) |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | Pascal through Blackwell (sm_60 - sm_100) |

### 2.1. Additional Python packages
- `jupyterlab` - Notebook interface
- `pandas` - Data manipulation
- `scikit-learn` - Machine learning utilities
- `scipy` - Scientific computing
- `matplotlib` - Data visualization
- `seaborn` - Statistical data visualization
- `tensorboard` - Training visualization
- `keras_tuner` - Hyperparameter tuning for Keras
- `optuna` - Hyperparameter optimization framework
- `ipywidgets` - Interactive widgets for Jupyter

## 3. Usage with VS Code Dev Containers

This image is designed for use with the [deeplearning-devcontainer](https://github.com/gperdrizet/deeplearning-devcontainer) repository, which provides ready-to-use VS Code Dev Container configurations. The `vscode` user (UID 1000) is pre-configured with sudo access for a seamless development experience.

## 4. Running directly with Docker

```bash
docker run --rm -it \
  --gpus all \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/deeplearning-nvidia:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```


## 5. Requirements

- Docker with NVIDIA GPU support and host driver >= 570.x
- NVIDIA Container Toolkit

## 6. License

See the [GitHub repository](https://github.com/gperdrizet/deeplearning-devcontainer) for license information.
