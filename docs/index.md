# Docker Images

[![Build and test](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml/badge.svg)](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml)
[![Docs](https://github.com/gperdrizet/docker-images/actions/workflows/docs.yml/badge.svg)](https://gperdrizet.github.io/docker-images/)
[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![CUDA](https://img.shields.io/badge/CUDA-12.8-76B900?logo=nvidia&logoColor=white)](https://developer.nvidia.com/cuda-toolkit)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.11.0-EE4C2C?logo=pytorch&logoColor=white)](https://pytorch.org/)
[![TensorFlow](https://img.shields.io/badge/TensorFlow-2.17-FF6F00?logo=tensorflow&logoColor=white)](https://www.tensorflow.org/)
[![RAPIDS](https://img.shields.io/badge/RAPIDS-26.2-7400FF?logo=nvidia&logoColor=white)](https://rapids.ai/)
[![LangChain](https://img.shields.io/badge/LangChain-latest-1C3C3C)](https://python.langchain.com/)

Twelve containerized AI/ML environments in four families (**datascience**, **deeplearning**, **llms**, and **kaggle**), each available for NVIDIA GPU, CPU, and Apple Silicon. Used via the devcontainer repos below, which add VS Code configuration and project scaffolding so setup is a single `git clone`.

| Devcontainer repo | Purpose | Hardware |
|---|---|---|
| [`datascience-devcontainer`](https://github.com/gperdrizet/datascience-devcontainer) | Intro data science | NVIDIA GPU · CPU · Mac |
| [`deeplearning-devcontainer`](https://github.com/gperdrizet/deeplearning-devcontainer) | TensorFlow + PyTorch | NVIDIA GPU · CPU · Mac |
| [`llms-devcontainer`](https://github.com/gperdrizet/llms-devcontainer) | LLM application development | NVIDIA GPU · CPU · Mac |
| [`kaggle-devcontainer`](https://github.com/gperdrizet/kaggle-devcontainer) | Kaggle competitions | NVIDIA GPU · CPU · Mac |

## Goals

1. **Eliminate setup friction**: clone a devcontainer repo, open in VS Code, done. No manual environment configuration.
2. **Wide hardware support**: GPU images cover Pascal through Blackwell; CPU fallbacks for machines without a GPU; native `linux/arm64` for Apple Silicon.
3. **Low barrier to entry**: any machine works. A 16GB P100 can be had on eBay for ~$90, enough to train deep learning models and host LLMs without cloud compute or proprietary APIs.
4. **Standardized environments**: the same software stack across all platforms, reducing troubleshooting burden and making community support easier.

## Documentation

Full documentation (usage guide, development reference, and per-image specifications) is at:

**[https://gperdrizet.github.io/docker-images/](https://gperdrizet.github.io/docker-images/)**

## License

[MIT](../LICENSE); built images incorporate third-party base images with their own upstream licenses.
