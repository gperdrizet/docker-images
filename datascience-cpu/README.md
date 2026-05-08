# Data science CPU development container

Lightweight data science environment for intro Python, data visualization, data cleaning, feature engineering, and traditional machine learning. No deep learning frameworks; keeps the image small and fast.

## 1. Features

- **Lightweight and portable:** No GPU required; runs on any linux/amd64 machine with Docker
- **No deep learning frameworks:** Keeps the image small and fast, focused on classical ML and data analysis
- **VS Code Dev Container ready:** Pre-configured `vscode` user (UID 1000) with sudo access for seamless devcontainer integration

## 2. Included software

| Component | Version |
|-----------|--------|
| Base Image | `python:3.12-slim` |
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
  gperdrizet/datascience-cpu:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## 5. Requirements

- Docker

## 6. License

MIT. See [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
