# Deep learning GPU development environment

A ready-to-use deep learning environment with NVIDIA GPU support for VS Code. Includes both **PyTorch** and **TensorFlow** frameworks. Designed for cross-platform support and wide GPU compatibility.

**Base image**: [NVIDIA TensorFlow 24.08](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/tensorflow)

> **Note:** This container is designed to be used as part of a VS Code Dev Container environment, not run directly. See the [full environment setup on GitHub](https://github.com/gperdrizet/deeplearning-GPU) for devcontainer configuration and usage instructions.

## Features

- **Dual Framework Support** – Both TensorFlow 2.16 and PyTorch 2.10 pre-installed and GPU-ready
- **NVIDIA GPU Acceleration** – Built on NVIDIA's official TensorFlow container with CUDA 12.6 support
- **VS Code Dev Container Ready** – Pre-configured `vscode` user for seamless devcontainer integration
- **Data Science Tools** – Includes common data science and ML libraries like Pandas & Scikit-learn

## Included software

| Component | Version |
|-----------|---------|
| Base Image | `nvcr.io/nvidia/tensorflow:24.08-tf2-py3` |
| TensorFlow | 2.16 |
| Keras | 3.3 |
| PyTorch | 2.10 |
| Python | 3.10 |
| CUDA | 12.6 |

### Additional Python packages
- `numpy` - Numerical computation
- `pandas` - Data manipulation
- `sckit-learn` - Classical machine learning
- `scipy` - Scientific and statistical computing
- `matplotlib` - Data visualization
- `seaborn` - Statistical data visualization
- `tensorboard` - Machine learning experiment visualization toolkit
- `keras_tuner` - Hyperparameter tuning for Keras
- `optuna` - General purpose hyperparameter optimization framework
- `jupyterlab` - Interactive notebook development environment

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

See the [GitHub repository](https://github.com/gperdrizet/deeplearning-GPU) for license information.
