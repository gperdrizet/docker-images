# Kaggle NVIDIA GPU development container

Development environment mirroring the Kaggle notebook GPU environment as closely as possible. Package versions are pinned to match the pip freeze of a Kaggle GPU notebook session (Python 3.12, CUDA 12.8), so code developed here behaves the same when submitted to competitions.

**Bonus over Kaggle itself:** this image ships a custom-built PyTorch 2.10.0 wheel with Pascal-through-Blackwell support (sm_60–sm_100). Kaggle ships the stock cu128 wheel, which has no Pascal kernels — torch on Kaggle's own P100s fails with `no kernel image is available`. Same torch version, but it actually works on P100/GTX 10xx hardware.

## 1. Features

- Python 3.12, CUDA 12.8.1 + cuDNN — matches the Kaggle GPU runtime
- PyTorch 2.10.0 (custom wheel, sm_60–sm_100), TensorFlow 2.20.0, Keras 3.13.2
- RAPIDS: cuDF 26.2.1, cuML 26.2.0, CuPy 14.0.1 (GPU dataframes/ML)
- scikit-learn 1.6.1, XGBoost 3.2.0, LightGBM 4.6.0, CatBoost 1.2.10
- numpy 2.0.2, pandas 2.3.3, polars 1.35.2
- transformers 5.0.0, datasets, sentence-transformers, accelerate, peft
- opencv, albumentations, scikit-image
- optuna, shap, matplotlib, seaborn, plotly
- `kaggle` and `kagglehub` CLI/API tooling
- JupyterLab 3.6.8 (the version Kaggle ships)

## 2. GPU compatibility

| Component | Pascal (P100/GTX 10xx, sm_60) | Volta+ (sm_70+) |
|---|---|---|
| PyTorch (custom wheel) | ✅ works (unlike Kaggle!) | ✅ works |
| RAPIDS (cuDF/cuML/CuPy) | ❌ requires sm_70+ (same on Kaggle) | ✅ works |
| XGBoost GPU | ✅ works | ✅ works |

Requires the NVIDIA Container Toolkit and host driver >= 570.x.

## 3. Usage with VS Code

Start the container, then use VS Code's **Dev Containers: Attach to Running Container** command to connect:

```bash
docker run --rm -it --gpus all \
  -v $(pwd):/workspace \
  gperdrizet/kaggle-nvidia:latest \
  /bin/bash
```

Open the Command Palette (`Ctrl+Shift+P`), run **Dev Containers: Attach to Running Container**, and select the container.

## 4. Running directly with Docker

```bash
docker run --rm -it --gpus all \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/kaggle-nvidia:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## 5. Notes on environment fidelity

- Versions are pinned from a Kaggle GPU session freeze (2026-07). Kaggle updates its environment periodically; new image releases track those updates.
- Colab-internal packages (`google-colab`, Kaggle's `learntools`, GCP client libraries) are excluded — they only exist inside Kaggle's managed runtime.
- For CPU-only work, see `gperdrizet/kaggle-cpu` (x86) or `gperdrizet/kaggle-mac` (Apple Silicon).

## 6. Requirements

- Docker with NVIDIA Container Toolkit
- NVIDIA driver >= 570.x

## 7. License

MIT. See [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
