# Data science CPU development container

Lightweight data science environment for intro Python, data visualization, data cleaning, feature engineering, and traditional machine learning. No deep learning frameworks; keeps the image small and fast.

## 1. Features

- Python 3.12
- JupyterLab
- scikit-learn, XGBoost, statsmodels
- pandas, numpy, scipy
- matplotlib, seaborn, plotly
- optuna (hyperparameter optimization)
- CPU only, linux/amd64; works on any machine

## 2. Included software

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
| Python | 3.12 |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna

## 3. Usage with VS Code Dev Containers

This image is designed for use with the [datascience-devcontainer](https://github.com/gperdrizet/datascience-devcontainer) repository, which provides ready-to-use VS Code Dev Container configurations. The `vscode` user (UID 1000) is pre-configured with sudo access for a seamless development experience.

## 4. Running directly with Docker

```bash
docker run --rm -it \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-cpu:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## 5. Requirements

- Docker

## 6. License

MIT. See [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
