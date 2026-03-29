# Deep learning CPU development environment

A ready-to-use deep learning environment for VS Code. Includes both **PyTorch** and **TensorFlow** frameworks. Designed for CPU-only systems or development without GPU dependencies.

> **Note:** This container is designed to be used as part of a VS Code Dev Container environment, not run directly. See the [full environment setup on GitHub](https://github.com/gperdrizet/deeplearning-devcontainer) for devcontainer configuration and usage instructions.

## Features

- **Dual Framework Support** – Both TensorFlow 2.17 and PyTorch (CPU) pre-installed
- **Lightweight & Portable** – No GPU or CUDA dependencies required
- **VS Code Dev Container Ready** – Pre-configured `vscode` user for seamless devcontainer integration

## Included software

| Component | Version |
|-----------|---------|
| Base Image | `tensorflow/tensorflow:2.17.0` |
| TensorFlow | 2.17 (CPU) |
| Keras | 3.x |
| PyTorch | Latest (CPU) |
| Python | 3.12 |

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
docker run -p 8888:8888 -v $(pwd):/workspace gperdrizet/deeplearning-cpu:latest \
    jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --notebook-dir=/workspace \
    --NotebookApp.token=''
```

This will:
- Map port 8888 for Jupyter access
- Mount your current directory to `/workspace` in the container
- Start a Jupyter notebook server accessible at `http://localhost:8888`
- Disable token authentication (suitable for LAN-only environments)

> **Security Note:** Only disable authentication on trusted networks. For public or untrusted networks, remove `--NotebookApp.token=''` to require token authentication.

## Requirements

- Docker

## License

See the [GitHub repository](https://github.com/gperdrizet/deeplearning-devcontainer) for license information.
