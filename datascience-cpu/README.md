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

## 2. Usage with VS Code

Start the container, then use VS Code's **Dev Containers: Attach to Running Container** command to connect:

```bash
docker run --rm -it \
  -v $(pwd):/workspace \
  gperdrizet/datascience-cpu:latest \
  /bin/bash
```

Open the Command Palette (`Ctrl+Shift+P`), run **Dev Containers: Attach to Running Container**, and select the container.

## 3. Running directly with Docker

```bash
docker run --rm -it \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-cpu:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## 4. Requirements

- Docker

## 5. License

MIT. See [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
