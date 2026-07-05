# Kaggle Mac (ARM64) development container

Development environment mirroring the Kaggle notebook submission environment as closely as possible, built natively for Apple Silicon (linux/arm64). Package versions are pinned to match the pip freeze of a Kaggle CPU notebook session (Python 3.12), so code developed here behaves the same when submitted to competitions.

## 1. Features

- Python 3.12, matches the Kaggle notebook runtime
- PyTorch 2.10.0 (CPU), TensorFlow 2.20.0, Keras 3.13.2
- scikit-learn 1.6.1, XGBoost 3.2.0, LightGBM 4.6.0, CatBoost 1.2.10
- numpy 2.0.2, pandas 2.3.3, polars 1.35.2
- transformers 5.0.0, datasets, sentence-transformers
- opencv, albumentations, scikit-image
- optuna, shap, matplotlib, seaborn, plotly
- `kaggle` and `kagglehub` CLI/API tooling
- JupyterLab 3.6.8 (the version Kaggle ships)
- Native linux/arm64, no Rosetta emulation on M1/M2/M3 Macs

## 2. Usage with VS Code

Start the container, then use VS Code's **Dev Containers: Attach to Running Container** command to connect:

```bash
docker run --rm -it \
  -v $(pwd):/workspace \
  gperdrizet/kaggle-mac:latest \
  /bin/bash
```

Open the Command Palette (`Cmd+Shift+P`), run **Dev Containers: Attach to Running Container**, and select the container.

## 3. Running directly with Docker

```bash
docker run --rm -it \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  gperdrizet/kaggle-mac:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

## 4. Notes on environment fidelity

- Versions are pinned from a Kaggle CPU session freeze (2026-07). Kaggle updates its environment periodically; new image releases track those updates.
- No GPU acceleration; Metal/MPS is not accessible inside Docker containers.
- Colab-internal packages (`google-colab`, Kaggle's `learntools`, GCP client libraries) are excluded; they only exist inside Kaggle's managed runtime.

## 5. Requirements

- Docker Desktop for Mac (Apple Silicon)

## 6. License

MIT. See [docker-images](https://github.com/gperdrizet/docker-images/blob/main/LICENSE).
