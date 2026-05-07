# Data science Mac (ARM64) development container

Native ARM64 data science environment for Apple Silicon (M1/M2/M3) Macs. Runs without Rosetta emulation in Docker Desktop. Covers intro Python, data visualization, data cleaning, feature engineering, and traditional machine learning.

> **Note:** GPU acceleration is not available inside Docker containers on Apple Silicon: Metal/MPS is a macOS-only framework with no Docker passthrough. This image provides native ARM64 CPU performance only.

## 1. Features

- Python 3.12
- JupyterLab
- scikit-learn, XGBoost, statsmodels
- pandas, numpy, scipy
- matplotlib, seaborn, plotly
- optuna (hyperparameter optimization)
- linux/arm64, native Apple Silicon, no Rosetta

## 2. Usage with VS Code

Start the container, then use VS Code's **Dev Containers: Attach to Running Container** command to connect:

```bash
docker run --rm -it \
  -v $(pwd):/workspace \
  gperdrizet/datascience-mac:latest \
  /bin/bash
```

Open the Command Palette (`Ctrl+Shift+P`), run **Dev Containers: Attach to Running Container**, and select the container.

## 3. Running directly with Docker

```bash
docker run --rm -it \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/datascience-mac:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## 4. Requirements

- Docker Desktop for Mac (Apple Silicon)

## 5. License

MIT. See [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
