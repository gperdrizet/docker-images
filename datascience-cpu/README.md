# Data Science CPU Development Container

Lightweight data science environment for intro Python, data visualisation, data cleaning, feature engineering, and traditional machine learning. No deep learning frameworks — keeps the image small and fast.

## Features

- Python 3.12
- JupyterLab
- scikit-learn, XGBoost, statsmodels
- pandas, numpy, scipy
- matplotlib, seaborn, plotly
- optuna (hyperparameter optimisation)
- CPU only, linux/amd64 — works on any machine

## Usage with VS Code Dev Containers

See [`gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer).

## Running Directly with Docker

```bash
docker run --rm -it \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-cpu:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## Requirements

- Docker

## License

MIT — see [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
