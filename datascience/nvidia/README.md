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

## 2. Usage with VS Code

Start the container, then use VS Code's **Dev Containers: Attach to Running Container** command to connect:

```bash
docker run --rm -it \
  --gpus all \
  -v $(pwd):/workspace \
  gperdrizet/datascience-nvidia:latest \
  /bin/bash
```

Open the Command Palette (`Ctrl+Shift+P`), run **Dev Containers: Attach to Running Container**, and select the container.

## 3. Running directly with Docker

```bash
docker run --rm -it \
  --gpus all \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-nvidia:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## 4. Requirements

- Docker with NVIDIA GPU support and host driver >= 570.x
- NVIDIA Container Toolkit

## 5. License

MIT. See [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
