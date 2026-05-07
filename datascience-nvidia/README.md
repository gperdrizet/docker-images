# Data Science NVIDIA GPU Development Container

Data science environment with NVIDIA GPU acceleration for XGBoost and CuPy (GPU-accelerated NumPy). Covers intro Python, data visualisation, data cleaning, feature engineering, and traditional machine learning.

## Features

- Python 3.12
- JupyterLab
- scikit-learn, XGBoost (GPU), statsmodels
- pandas, numpy, scipy
- CuPy (GPU-accelerated NumPy-compatible arrays)
- matplotlib, seaborn, plotly
- optuna (hyperparameter optimisation)
- CUDA 12.8, Pascal through Blackwell (sm_60-sm_100)

## Usage with VS Code Dev Containers

See [`gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer).

## Running Directly with Docker

```bash
docker run --rm -it \
  --gpus all \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-nvidia:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## Requirements

- Docker with NVIDIA GPU support and host driver >= 570.x
- NVIDIA Container Toolkit

## License

MIT — see [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
