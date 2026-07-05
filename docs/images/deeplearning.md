# deeplearning images

Full-featured deep learning environment with TensorFlow and PyTorch. Three variants: NVIDIA GPU, CPU-only, and Apple Silicon.

---

## deeplearning-nvidia

Based on NVIDIA's NGC TensorFlow container, which provides a validated CUDA + cuDNN + TensorFlow stack with Pascal support out of the box. PyTorch and CuPy are added via custom-built wheels (see [Building Custom Wheels](../development/wheels.md)).

| Component | Version |
|-----------|---------|
| Base image | `nvcr.io/nvidia/tensorflow:25.02-tf2-py3` |
| Python | 3.12 |
| CUDA | 12.8 |
| TensorFlow | 2.17 |
| PyTorch | 2.11.0 (custom wheel) |
| CuPy | 13.6.0 (custom wheel) |
| Keras | 3.x |
| GPU support | Pascal–Blackwell (sm_60–sm_100) |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, plotly, jupyterlab, keras_tuner, optuna, tensorboard, python-dotenv

**DockerHub:** [`gperdrizet/deeplearning-nvidia`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-nvidia/general)

---

## deeplearning-cpu

| Component | Version |
|-----------|---------|
| Base image | `python:3.12-slim` |
| Python | 3.12 |
| TensorFlow | 2.x (latest via pip) |
| PyTorch | Latest CPU (via pip) |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, plotly, jupyterlab, keras_tuner, optuna, tensorboard, python-dotenv

**DockerHub:** [`gperdrizet/deeplearning-cpu`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-cpu/general)

---

## deeplearning-mac

Native `linux/arm64` image for Apple Silicon (M1/M2/M3). No Rosetta emulation. GPU acceleration is not available inside Docker on macOS.

| Component | Version |
|-----------|---------|
| Base image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| Python | 3.12 |
| TensorFlow | 2.17 |
| Keras | 3.x |
| PyTorch | Latest (CPU, ARM64) |

**Other packages:** numpy, pandas, scikit-learn, scipy, matplotlib, seaborn, plotly, jupyterlab, keras_tuner, optuna, tensorboard, python-dotenv

**DockerHub:** [`gperdrizet/deeplearning-mac`](https://hub.docker.com/repository/docker/gperdrizet/deeplearning-mac/general)
