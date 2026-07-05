# datascience images

Lightweight data science environment for intro Python and ML courses. Three variants: NVIDIA GPU (with CuPy acceleration), CPU-only, and Apple Silicon.

---

## datascience-nvidia

| Component | Version |
|-----------|--------|
| Base image | `nvidia/cuda:12.8.1-runtime-ubuntu24.04` |
| Python | 3.12 |
| CUDA | 12.8 |
| GPU support | Pascal–Blackwell (sm_60–sm_100) |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna, python-dotenv, cupy 13.6.0 (custom wheel)

**DockerHub:** [`gperdrizet/datascience-nvidia`](https://hub.docker.com/repository/docker/gperdrizet/datascience-nvidia/general)

---

## datascience-cpu

| Component | Version |
|-----------|--------|
| Base image | `python:3.12-slim` |
| Python | 3.12 |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna, python-dotenv

**DockerHub:** [`gperdrizet/datascience-cpu`](https://hub.docker.com/repository/docker/gperdrizet/datascience-cpu/general)

---

## datascience-mac

Native `linux/arm64` image for Apple Silicon (M1/M2/M3). Docker Desktop on Mac runs it without emulation. GPU/Metal passthrough is not supported inside Docker on macOS.

| Component | Version |
|-----------|--------|
| Base image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| Python | 3.12 |

**Packages:** numpy, pandas, scipy, scikit-learn, xgboost, statsmodels, matplotlib, seaborn, plotly, jupyterlab, optuna, python-dotenv

**DockerHub:** [`gperdrizet/datascience-mac`](https://hub.docker.com/repository/docker/gperdrizet/datascience-mac/general)
