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

<table>
  <thead>
    <tr>
      <th>Devcontainer repo</th>
      <th>Purpose</th>
      <th>Hardware</th>
      <th>Image</th>
      <th>Pulls</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/datascience-devcontainer"><code>datascience-devcontainer</code></a></td>
      <td rowspan="3">Intro data science</td>
      <td>NVIDIA GPU</td>
      <td><code>datascience-nvidia</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/datascience-nvidia"><img src="https://img.shields.io/docker/pulls/gperdrizet/datascience-nvidia?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>datascience-cpu</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/datascience-cpu"><img src="https://img.shields.io/docker/pulls/gperdrizet/datascience-cpu?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>datascience-mac</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/datascience-mac"><img src="https://img.shields.io/docker/pulls/gperdrizet/datascience-mac?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/deeplearning-devcontainer"><code>deeplearning-devcontainer</code></a></td>
      <td rowspan="3">Deep learning (TensorFlow + PyTorch)</td>
      <td>NVIDIA GPU</td>
      <td><code>deeplearning-nvidia</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/deeplearning-nvidia"><img src="https://img.shields.io/docker/pulls/gperdrizet/deeplearning-nvidia?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>deeplearning-cpu</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/deeplearning-cpu"><img src="https://img.shields.io/docker/pulls/gperdrizet/deeplearning-cpu?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>deeplearning-mac</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/deeplearning-mac"><img src="https://img.shields.io/docker/pulls/gperdrizet/deeplearning-mac?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/llms-devcontainer"><code>llms-devcontainer</code></a></td>
      <td rowspan="3">LLM application development</td>
      <td>NVIDIA GPU</td>
      <td><code>llms-nvidia</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/llms-nvidia"><img src="https://img.shields.io/docker/pulls/gperdrizet/llms-nvidia?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>llms-cpu</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/llms-cpu"><img src="https://img.shields.io/docker/pulls/gperdrizet/llms-cpu?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>llms-mac</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/llms-mac"><img src="https://img.shields.io/docker/pulls/gperdrizet/llms-mac?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/kaggle-devcontainer"><code>kaggle-devcontainer</code></a></td>
      <td rowspan="3">Kaggle competitions</td>
      <td>NVIDIA GPU</td>
      <td><code>kaggle-nvidia</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/kaggle-nvidia"><img src="https://img.shields.io/docker/pulls/gperdrizet/kaggle-nvidia?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
      <td>CPU</td>
      <td><code>kaggle-cpu</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/kaggle-cpu"><img src="https://img.shields.io/docker/pulls/gperdrizet/kaggle-cpu?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>kaggle-mac</code></td>
      <td><a href="https://hub.docker.com/r/gperdrizet/kaggle-mac"><img src="https://img.shields.io/docker/pulls/gperdrizet/kaggle-mac?label=&color=2496ED&logo=docker&logoColor=white" alt="pulls"></a></td>
    </tr>
  </tbody>
</table>

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
