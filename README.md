# Docker Images

[![CI](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml/badge.svg)](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml)

[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![CUDA](https://img.shields.io/badge/CUDA-12.8-76B900?logo=nvidia&logoColor=white)](https://developer.nvidia.com/cuda-toolkit)
[![JupyterLab](https://img.shields.io/badge/JupyterLab-3.6.8-F37626?logo=jupyter&logoColor=white)](https://jupyterlab.readthedocs.io/)
[![NumPy](https://img.shields.io/badge/NumPy-2.0.2-013243?logo=numpy&logoColor=white)](https://numpy.org/)
[![pandas](https://img.shields.io/badge/pandas-2.3.3-150458?logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![Matplotlib](https://img.shields.io/badge/Matplotlib-3.10.0-11557C?logo=matplotlib&logoColor=white)](https://matplotlib.org/)
[![scikit-learn](https://img.shields.io/badge/scikit--learn-1.6.1-F7931E?logo=scikitlearn&logoColor=white)](https://scikit-learn.org/)
[![XGBoost](https://img.shields.io/badge/XGBoost-3.2.0-189AB4)](https://xgboost.readthedocs.io/)
[![LightGBM](https://img.shields.io/badge/LightGBM-4.6.0-2980B9)](https://lightgbm.readthedocs.io/)
[![Optuna](https://img.shields.io/badge/Optuna-4.9.0-3EA7DC)](https://optuna.org/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.11.0-EE4C2C?logo=pytorch&logoColor=white)](https://pytorch.org/)
[![TensorFlow](https://img.shields.io/badge/TensorFlow-2.17-FF6F00?logo=tensorflow&logoColor=white)](https://www.tensorflow.org/)
[![RAPIDS](https://img.shields.io/badge/RAPIDS-26.2-7400FF?logo=nvidia&logoColor=white)](https://rapids.ai/)
[![Transformers](https://img.shields.io/badge/🤗_Transformers-latest-FFD21E)](https://huggingface.co/docs/transformers)
[![🤗 Datasets](https://img.shields.io/badge/🤗_Datasets-5.0.0-FFD21E)](https://huggingface.co/docs/datasets)
[![LangChain](https://img.shields.io/badge/LangChain-latest-1C3C3C)](https://python.langchain.com/)

Twelve containerized AI/ML environments in four families (**datascience**, **deeplearning**, **llms**, and **kaggle**), each available for NVIDIA GPU, CPU, and Apple Silicon. Used via the devcontainer repos below, which add VS Code configuration and project scaffolding so setup is a single `git clone`.

<table>
  <thead>
    <tr>
      <th>Devcontainer repo</th>
      <th>Purpose</th>
      <th>Hardware</th>
      <th>Image</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/datascience-devcontainer"><code>datascience-devcontainer</code></a></td>
      <td rowspan="3">Intro data science</td>
      <td>NVIDIA GPU</td>
      <td><code>datascience-nvidia</code></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>datascience-cpu</code></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>datascience-mac</code></td>
    </tr>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/deeplearning-devcontainer"><code>deeplearning-devcontainer</code></a></td>
      <td rowspan="3">Deep learning (TensorFlow + PyTorch)</td>
      <td>NVIDIA GPU</td>
      <td><code>deeplearning-nvidia</code></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>deeplearning-cpu</code></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>deeplearning-mac</code></td>
    </tr>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/llms-devcontainer"><code>llms-devcontainer</code></a></td>
      <td rowspan="3">LLM application development</td>
      <td>NVIDIA GPU</td>
      <td><code>llms-nvidia</code></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>llms-cpu</code></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>llms-mac</code></td>
    </tr>
    <tr>
      <td rowspan="3"><a href="https://github.com/gperdrizet/kaggle-devcontainer"><code>kaggle-devcontainer</code></a></td>
      <td rowspan="3">Kaggle competitions</td>
      <td>NVIDIA GPU</td>
      <td><code>kaggle-nvidia</code></td>
    </tr>
    <tr>
      <td>CPU</td>
      <td><code>kaggle-cpu</code></td>
    </tr>
    <tr>
      <td>Mac (Apple Silicon)</td>
      <td><code>kaggle-mac</code></td>
    </tr>
  </tbody>
</table>

### Goals

1. **Eliminate setup friction**: clone a devcontainer repo, open in VS Code, done. No manual environment configuration.
2. **Wide hardware support**: GPU images cover Pascal through Blackwell; CPU fallbacks for machines without a GPU; native `linux/arm64` for Apple Silicon.
3. **Low barrier to entry**: any machine works. A 16GB P100 can be had on eBay for ~$90, enough to train deep learning models and host LLMs without cloud compute or proprietary APIs.
4. **Standardized environments**: the same software stack across all platforms, reducing troubleshooting burden and making community support easier.

## Documentation

Full documentation (usage guide, development reference, and per-image specifications) is at:

**[https://gperdrizet.github.io/docker-images/](https://gperdrizet.github.io/docker-images)**

## License

The Dockerfiles, scripts, and documentation in this repository are licensed under the [MIT License](LICENSE). Built images incorporate third-party base images with their own upstream licenses.


