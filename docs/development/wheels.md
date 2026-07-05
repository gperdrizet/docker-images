# Building custom wheels

The NVIDIA images use custom-built wheels for wide GPU architecture support (Pascal through Blackwell, sm_60-sm_100). Pre-built wheels are hosted on GitHub Releases and downloaded during image build; wheel builds are infrequent and manual.

## When to rebuild

- Upgrading PyTorch or CuPy version
- Adding or removing GPU architecture support
- Updating the CUDA version in a base image

---

## PyTorch wheel

Used by `deeplearning-nvidia`, `llms-nvidia`, and `kaggle-nvidia`.

| Image | Python | CUDA | Wheel |
|-------|--------|------|-------|
| deeplearning-nvidia | 3.12 | 12.8 | `torch-X.Y.Z-cp312-cp312-linux_x86_64.whl` |
| llms-nvidia | 3.12 | 12.8 | same wheel (reused) |
| kaggle-nvidia | 3.12 | 12.8 | `torch-2.10.0-cp312-cp312-linux_x86_64.whl` (pinned to match Kaggle) |

### Build commands

| Command | Description |
|---------|-------------|
| `make wheel-deeplearning-nvidia` | Build PyTorch wheel (Python 3.12, CUDA 12.8) |
| `make extract-wheel-deeplearning-nvidia` | Extract wheel from builder container to `./wheels/` |

Override defaults via environment variables:

```bash
make wheel-deeplearning-nvidia PYTORCH_VERSION=2.12.0
make wheel-deeplearning-nvidia MAX_JOBS=8
make wheel-deeplearning-nvidia CUDA_ARCH_LIST="7.0;7.5;8.0;8.6"
```

### Full workflow

```bash
# 1. Build (~3-4 hours)
make wheel-deeplearning-nvidia

# 2. Extract to ./wheels/
make extract-wheel-deeplearning-nvidia

# 3. Upload to GitHub Releases
gh release create pytorch-2.11.0-cu128-cp312 \
  ./wheels/torch-2.11.0-cp312-cp312-linux_x86_64.whl \
  --title "PyTorch 2.11.0 CUDA 12.8 (Pascal-Blackwell)" \
  --notes "Custom PyTorch wheel with sm_60-sm_100 support"

# 4. Update WHEEL_URL in the relevant Dockerfiles, then rebuild via CI
```

---

## CuPy wheel

Used by `datascience-nvidia`.

| Image | Python | CUDA | Wheel |
|-------|--------|------|-------|
| datascience-nvidia | 3.12 | 12.8 | `cupy-X.Y.Z-cp312-cp312-linux_x86_64.whl` |

### Build commands

| Command | Description |
|---------|-------------|
| `make wheel-datascience-nvidia` | Build CuPy wheel (Python 3.12, CUDA 12.8) |
| `make extract-wheel-datascience-nvidia` | Extract wheel from builder container to `./wheels/` |

Override defaults:

```bash
make wheel-datascience-nvidia CUPY_VERSION=13.7.0
```

### Full workflow

```bash
# 1. Build (~1 hour)
make wheel-datascience-nvidia

# 2. Extract to ./wheels/
make extract-wheel-datascience-nvidia

# 3. Upload to GitHub Releases
gh release create cupy-13.6.0-cu128-cp312 \
  ./wheels/cupy-13.6.0-cp312-cp312-linux_x86_64.whl \
  --title "CuPy 13.6.0 CUDA 12.8 (Pascal-Blackwell)" \
  --notes "Custom CuPy wheel with sm_60-sm_100 support"

# 4. Update WHEEL_URL in datascience-nvidia/Dockerfile, then rebuild via CI
```
