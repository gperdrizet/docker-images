# Data Science Mac (ARM64) Development Container

Native ARM64 data science environment for Apple Silicon (M1/M2/M3) Macs. Runs without Rosetta emulation in Docker Desktop. Covers intro Python, data visualisation, data cleaning, feature engineering, and traditional machine learning.

> **Note:** GPU acceleration is not available inside Docker containers on Apple Silicon — Metal/MPS is a macOS-only framework with no Docker passthrough. This image provides native ARM64 CPU performance only.

## Features

- Python 3.12
- JupyterLab
- scikit-learn, XGBoost, statsmodels
- pandas, numpy, scipy
- matplotlib, seaborn, plotly
- optuna (hyperparameter optimisation)
- linux/arm64 — native Apple Silicon, no Rosetta

## Usage with VS Code Dev Containers

See [`gperdrizet/deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer).

## Running Directly with Docker

```bash
docker run --rm -it \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-mac:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## Requirements

- Docker Desktop for Mac (Apple Silicon)

## License

MIT — see [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
