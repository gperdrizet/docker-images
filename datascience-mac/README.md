# Data science Mac (ARM64) development container

Native ARM64 data science environment for Apple Silicon (M1/M2/M3) Macs. Runs without Rosetta emulation in Docker Desktop. Covers intro Python, data visualization, data cleaning, feature engineering, and traditional machine learning.

> **Note:** GPU acceleration is not available inside Docker containers on Apple Silicon: Metal/MPS is a macOS-only framework with no Docker passthrough. This image provides native ARM64 CPU performance only.

## 1. Features

- **Native Apple Silicon:** Built as `linux/arm64`; runs without Rosetta emulation in Docker Desktop on M1/M2/M3 Macs
- **No deep learning frameworks:** Focused on classical ML and data analysis, keeping the image lean
- **VS Code Dev Container ready:** Pre-configured `vscode` user (UID 1000) with sudo access for seamless devcontainer integration

## 2. Included software

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| Python | 3.12 |

### 2.1. Python packages

- `numpy` - Numerical computing
- `pandas` - Data manipulation
- `scipy` - Scientific computing
- `scikit-learn` - Machine learning
- `xgboost` - Gradient boosted trees
- `statsmodels` - Statistical modeling
- `matplotlib` - Data visualization
- `seaborn` - Statistical data visualization
- `plotly` - Interactive visualization
- `jupyterlab` - Notebook interface
- `optuna` - Hyperparameter optimization

## 3. Usage with VS Code Dev Containers

This image is designed for use with the [datascience-devcontainer](https://github.com/gperdrizet/datascience-devcontainer) repository, which provides ready-to-use VS Code Dev Container configurations. The `vscode` user (UID 1000) is pre-configured with sudo access for a seamless development experience.

## 4. Running directly with Docker

```bash
docker run --rm -it \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-mac:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## 5. Requirements

- Docker Desktop for Mac (Apple Silicon)

## 6. License

MIT. See [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
