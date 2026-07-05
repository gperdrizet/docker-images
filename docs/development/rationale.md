# Design Rationale

## datascience / deeplearning / llms

`datascience-*` is a lightweight intro ML stack. `deeplearning-nvidia` is based on NVIDIA's NGC TensorFlow container (validated CUDA + cuDNN + Pascal support out of the box); PyTorch is added via a custom-built wheel because official cu12x wheels dropped Pascal (sm_60). `llms-nvidia` follows the same custom-wheel approach on a minimal `nvidia/cuda` base. Mac variants are native `linux/arm64` images; CPU variants use `python:3.12-slim` with the same packages.

## kaggle

Package versions are pinned to match a Kaggle notebook pip freeze so local code behaves identically when submitted. The NVIDIA variant ships RAPIDS (cuDF/cuML/CuPy) and a custom PyTorch 2.10.0 wheel with Pascal support; Kaggle's own stock cu128 wheel has no Pascal kernels, so `torch` on Kaggle's P100s silently fails. Same version, but it actually works.
