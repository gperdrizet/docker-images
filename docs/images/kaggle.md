# kaggle images

Mirrors the Kaggle notebook environment. Package versions are pinned to match a Kaggle notebook pip freeze so code developed locally behaves identically when submitted to competitions. Three variants: NVIDIA GPU (with RAPIDS), CPU-only, and Apple Silicon.

---

## kaggle-nvidia

Uses a custom PyTorch 2.10.0 wheel with Pascal support; Kaggle's own stock cu128 wheel has no Pascal kernels, so `torch` on Kaggle's P100s silently fails. Same version, but it actually works. Includes the RAPIDS stack as found in Kaggle GPU sessions.

!!! note "RAPIDS hardware requirement"
    RAPIDS (cuDF/cuML/CuPy) requires Volta (sm_70) or newer. It is not functional on P100/GTX 10xx hardware; the same limitation applies on Kaggle itself.

| Component | Version |
|-----------|--------|
| Base image | `nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04` |
| Python | 3.12 |
| CUDA | 12.8.1 |
| PyTorch | 2.10.0 (custom wheel, sm_60-sm_100) |
| TensorFlow | 2.20.0 |
| cuDF | 26.2.1 |
| cuML | 26.2.0 |
| CuPy | 14.0.1 |

**ML packages:** scikit-learn 1.6.1, xgboost 3.2.0, lightgbm 4.6.0, catboost 1.2.10, transformers 5.0.0, keras 3.13.2

**Other packages:** numpy 2.0.2, pandas 2.3.3, polars, jupyterlab 3.6.8, optuna, shap, opencv, albumentations, kaggle, kagglehub

**DockerHub:** [`gperdrizet/kaggle-nvidia`](https://hub.docker.com/repository/docker/gperdrizet/kaggle-nvidia/general)

---

## kaggle-cpu

| Component | Version |
|-----------|--------|
| Base image | `python:3.12-slim` |
| Python | 3.12 |
| PyTorch | 2.10.0 (CPU) |
| TensorFlow | 2.20.0 |

**ML packages:** scikit-learn 1.6.1, xgboost 3.2.0, lightgbm 4.6.0, catboost 1.2.10, transformers 5.0.0, keras 3.13.2

**Other packages:** numpy 2.0.2, pandas 2.3.3, polars, jupyterlab 3.6.8, optuna, shap, opencv, albumentations, kaggle, kagglehub

**DockerHub:** [`gperdrizet/kaggle-cpu`](https://hub.docker.com/repository/docker/gperdrizet/kaggle-cpu/general)

---

## kaggle-mac

Native `linux/arm64` image for Apple Silicon (M1/M2/M3). No Rosetta emulation. GPU acceleration is not available inside Docker on macOS.

| Component | Version |
|-----------|--------|
| Base image | `python:3.12-slim` |
| Platform | `linux/arm64` |
| Python | 3.12 |
| PyTorch | 2.10.0 (CPU, ARM64) |
| TensorFlow | 2.20.0 |

**ML packages:** scikit-learn 1.6.1, xgboost 3.2.0, lightgbm 4.6.0, catboost 1.2.10, transformers 5.0.0, keras 3.13.2

**Other packages:** numpy 2.0.2, pandas 2.3.3, polars, jupyterlab 3.6.8, optuna, shap, opencv, albumentations, kaggle, kagglehub

**DockerHub:** [`gperdrizet/kaggle-mac`](https://hub.docker.com/repository/docker/gperdrizet/kaggle-mac/general)
