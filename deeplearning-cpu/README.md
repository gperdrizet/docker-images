# Deep learning CPU development environment

A ready-to-use deep learning environment for VS Code. Includes both **PyTorch** and **TensorFlow** frameworks. Designed for CPU-only systems or development without GPU dependencies.

> **Note:** This container is designed to be used as part of a VS Code Dev Container environment, not run directly. See the [full environment setup on GitHub](https://github.com/gperdrizet/deeplearning-devcontainer) for devcontainer configuration and usage instructions.

## 1. Features

- **Dual framework support:** Both TensorFlow 2.17 and PyTorch (CPU) pre-installed
- **Lightweight and portable:** No GPU or CUDA dependencies required
- **VS Code Dev Container ready:** Pre-configured `vscode` user for seamless devcontainer integration

## 2. Included software

| Component | Version |
|-----------|---------|
| Base Image | `python:3.12-slim` |
| TensorFlow | 2.17 |
| Keras | 3.x |
| PyTorch | Latest (CPU) |
| Python | 3.12 |

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
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/deeplearning-cpu:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## 5. Requirements

- Docker

## 6. License

See the [GitHub repository](https://github.com/gperdrizet/deeplearning-devcontainer) for license information.
