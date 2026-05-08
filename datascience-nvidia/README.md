# Data science NVIDIA GPU development container

Data science environment with NVIDIA GPU acceleration for XGBoost and CuPy (GPU-accelerated NumPy). Covers intro Python, data visualization, data cleaning, feature engineering, and traditional machine learning.

## 1. Features

- **NVIDIA GPU acceleration:** CuPy for GPU-accelerated array computing and XGBoost GPU backend via CUDA 12.8
- **Broad GPU compatibility:** Pascal through Blackwell (sm_60–sm_100), supports GTX 10xx through RTX 50xx/B200
- **VS Code Dev Container ready:** Pre-configured `vscode` user (UID 1000) with sudo access for seamless devcontainer integration

## 2. Included software

| Component | Version |
|-----------|--------|
| Base Image | `nvidia/cuda:12.8.1-runtime-ubuntu24.04` |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU Support | Pascal through Blackwell (sm_60 - sm_100) |

### 2.1. Python packages

- `numpy` - Numerical computing
- `pandas` - Data manipulation
- `scipy` - Scientific computing
- `scikit-learn` - Machine learning
- `xgboost` - Gradient boosted trees (GPU backend)
- `statsmodels` - Statistical modeling
- `matplotlib` - Data visualization
- `seaborn` - Statistical data visualization
- `plotly` - Interactive visualization
- `jupyterlab` - Notebook interface
- `optuna` - Hyperparameter optimization
- `cupy-cuda12x` - GPU-accelerated NumPy-compatible arrays

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
