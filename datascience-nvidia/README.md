# Data science NVIDIA GPU development container

Data science environment with NVIDIA GPU acceleration for XGBoost and CuPy (GPU-accelerated NumPy). Covers intro Python, data visualization, data cleaning, feature engineering, and traditional machine learning.

## 1. Features

- Python 3.12
- JupyterLab
- scikit-learn, XGBoost (GPU), statsmodels
- pandas, numpy, scipy
- CuPy (GPU-accelerated NumPy-compatible arrays)
- matplotlib, seaborn, plotly
- optuna (hyperparameter optimization)
- CUDA 12.8, Pascal through Blackwell (sm_60-sm_100)

## 2. Included software

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.8.1-runtime-ubuntu24.04` |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | Pascal through Blackwell (sm_60 - sm_100) |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna, cupy-cuda12x

## 3. Usage with VS Code Dev Containers

This image is designed for use with the [datascience-devcontainer](https://github.com/gperdrizet/datascience-devcontainer) repository, which provides ready-to-use VS Code Dev Container configurations. The `vscode` user (UID 1000) is pre-configured with sudo access for a seamless development experience.

## 4. Running directly with Docker

```bash
docker run --rm -it \
  --gpus all \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-nvidia:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## 5. Requirements

- Docker with NVIDIA GPU support and host driver >= 570.x
- NVIDIA Container Toolkit

## 6. License

MIT. See [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
