# Docker Images

[![Build and test](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml/badge.svg)](https://github.com/gperdrizet/docker-images/actions/workflows/ci.yml)
[![Docs](https://github.com/gperdrizet/docker-images/actions/workflows/docs.yml/badge.svg)](https://gperdrizet.github.io/docker-images/)
[![Documentation](https://img.shields.io/badge/Documentation-GitHub%20Pages-0A66C2?logo=github&logoColor=white)](https://gperdrizet.github.io/docker-images/)
[![DockerHub](https://img.shields.io/badge/DockerHub-gperdrizet-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/u/gperdrizet)

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

### Goals

1. **Eliminate setup friction**: clone a devcontainer repo, open in VS Code, done. No manual environment configuration.
2. **Wide hardware support**: GPU images cover Pascal through Blackwell; CPU fallbacks for machines without a GPU; native `linux/arm64` for Apple Silicon.
3. **Low barrier to entry**: any machine works. A 16GB P100 can be had on eBay for ~$90, enough to train deep learning models and host LLMs without cloud compute or proprietary APIs.
4. **Standardized environments**: the same software stack across all platforms, reducing troubleshooting burden and making community support easier.

## Documentation

For full documentation (usage guide, development reference, and per-image specifications) see:

**[Docker images documentation](https://gperdrizet.github.io/docker-images)**

## Usage

**Requirements:**
- CPU images: Docker
- NVIDIA GPU images: Docker + NVIDIA Container Toolkit + host driver >= 570.x
- Mac images: Docker Desktop for Apple Silicon

**With VS Code (recommended):** start the container, then open the Command Palette (`Ctrl+Shift+P`) and run **Dev Containers: Attach to Running Container**. The `vscode` user is pre-configured with sudo access and a standard project layout. See the [devcontainer repos](#docker-images) above for a one-click setup that handles all of this automatically.

**Standalone with JupyterLab:** expose port 8888 and launch the server:

```bash
# CPU
docker run --rm -it -p 8888:8888 -v $(pwd):/workspace \
  gperdrizet/datascience-cpu:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root

# NVIDIA GPU
docker run --rm -it --gpus all -p 8888:8888 -v $(pwd):/workspace \
  gperdrizet/datascience-nvidia:latest \
  jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```

Replace the image name with whichever family and variant you need. The `-v $(pwd):/workspace` flag mounts your current directory into the container so files persist after the container stops.

## Image families

**`datascience`**

[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![CUDA](https://img.shields.io/badge/CUDA-12.8-76B900?logo=nvidia&logoColor=white)](https://developer.nvidia.com/cuda-toolkit)
[![JupyterLab](https://img.shields.io/badge/JupyterLab-latest-F37626?logo=jupyter&logoColor=white)](https://jupyterlab.readthedocs.io/)
[![NumPy](https://img.shields.io/badge/NumPy-1.26.4-013243?logo=numpy&logoColor=white)](https://numpy.org/)
[![pandas](https://img.shields.io/badge/pandas-2.2.3-150458?logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![SciPy](https://img.shields.io/badge/SciPy-latest-8CAAE6?logo=scipy&logoColor=white)](https://scipy.org/)
[![Matplotlib](https://img.shields.io/badge/Matplotlib-latest-11557C?logo=matplotlib&logoColor=white)](https://matplotlib.org/)
[![Seaborn](https://img.shields.io/badge/Seaborn-latest-4C72B0)](https://seaborn.pydata.org/)
[![Plotly](https://img.shields.io/badge/Plotly-latest-3F4F75?logo=plotly&logoColor=white)](https://plotly.com/python/)
[![scikit-learn](https://img.shields.io/badge/scikit--learn-latest-F7931E?logo=scikitlearn&logoColor=white)](https://scikit-learn.org/)
[![XGBoost](https://img.shields.io/badge/XGBoost-latest-189AB4)](https://xgboost.readthedocs.io/)
[![Optuna](https://img.shields.io/badge/Optuna-latest-3EA7DC)](https://optuna.org/)

Lightweight intro ML environment. Covers Python, data wrangling, visualization, and classical machine learning. No deep learning frameworks; keeps the image small and fast. The NVIDIA variant adds GPU-accelerated arrays via CuPy.

**`deeplearning`**

[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![CUDA](https://img.shields.io/badge/CUDA-12.8-76B900?logo=nvidia&logoColor=white)](https://developer.nvidia.com/cuda-toolkit)
[![JupyterLab](https://img.shields.io/badge/JupyterLab-latest-F37626?logo=jupyter&logoColor=white)](https://jupyterlab.readthedocs.io/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.11.0-EE4C2C?logo=pytorch&logoColor=white)](https://pytorch.org/)
[![TensorFlow](https://img.shields.io/badge/TensorFlow-2.17-FF6F00?logo=tensorflow&logoColor=white)](https://www.tensorflow.org/)
[![Keras](https://img.shields.io/badge/Keras-3.x-D00000?logo=keras&logoColor=white)](https://keras.io/)
[![NumPy](https://img.shields.io/badge/NumPy-latest-013243?logo=numpy&logoColor=white)](https://numpy.org/)
[![pandas](https://img.shields.io/badge/pandas-latest-150458?logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![scikit-learn](https://img.shields.io/badge/scikit--learn-latest-F7931E?logo=scikitlearn&logoColor=white)](https://scikit-learn.org/)
[![Optuna](https://img.shields.io/badge/Optuna-latest-3EA7DC)](https://optuna.org/)

Full deep learning stack with both TensorFlow 2.17 and PyTorch 2.11.0 pre-installed and GPU-ready. Built on NVIDIA's official NGC TensorFlow container, with PyTorch and CuPy added via custom-built wheels for wide GPU architecture support (Pascal through Blackwell).

**`llms`**

[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![CUDA](https://img.shields.io/badge/CUDA-12.8-76B900?logo=nvidia&logoColor=white)](https://developer.nvidia.com/cuda-toolkit)
[![JupyterLab](https://img.shields.io/badge/JupyterLab-latest-F37626?logo=jupyter&logoColor=white)](https://jupyterlab.readthedocs.io/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.11.0-EE4C2C?logo=pytorch&logoColor=white)](https://pytorch.org/)
[![Transformers](https://img.shields.io/badge/🤗_Transformers-latest-FFD21E)](https://huggingface.co/docs/transformers)
[![🤗 Datasets](https://img.shields.io/badge/🤗_Datasets-5.0.0-FFD21E)](https://huggingface.co/docs/datasets)
[![LangChain](https://img.shields.io/badge/LangChain-latest-1C3C3C)](https://python.langchain.com/)
[![Gradio](https://img.shields.io/badge/Gradio-latest-FF7C00?logo=gradio&logoColor=white)](https://gradio.app/)

LLM application development. Includes LangChain, LlamaIndex, Hugging Face Transformers, ChromaDB, and API clients for OpenAI, Anthropic, and Ollama. PyTorch is included via a custom-built wheel with wide GPU support. Designed for building and running LLM-powered applications locally.

**`kaggle`**

[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![CUDA](https://img.shields.io/badge/CUDA-12.8-76B900?logo=nvidia&logoColor=white)](https://developer.nvidia.com/cuda-toolkit)
[![JupyterLab](https://img.shields.io/badge/JupyterLab-3.6.8-F37626?logo=jupyter&logoColor=white)](https://jupyterlab.readthedocs.io/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.10.0-EE4C2C?logo=pytorch&logoColor=white)](https://pytorch.org/)
[![TensorFlow](https://img.shields.io/badge/TensorFlow-2.20.0-FF6F00?logo=tensorflow&logoColor=white)](https://www.tensorflow.org/)
[![Keras](https://img.shields.io/badge/Keras-3.13.2-D00000?logo=keras&logoColor=white)](https://keras.io/)
[![RAPIDS](https://img.shields.io/badge/RAPIDS-26.2-7400FF?logo=nvidia&logoColor=white)](https://rapids.ai/)
[![NumPy](https://img.shields.io/badge/NumPy-2.0.2-013243?logo=numpy&logoColor=white)](https://numpy.org/)
[![pandas](https://img.shields.io/badge/pandas-2.3.3-150458?logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![Polars](https://img.shields.io/badge/Polars-1.35.2-CD792C?logo=polars&logoColor=white)](https://pola.rs/)
[![scikit-learn](https://img.shields.io/badge/scikit--learn-1.6.1-F7931E?logo=scikitlearn&logoColor=white)](https://scikit-learn.org/)
[![XGBoost](https://img.shields.io/badge/XGBoost-3.2.0-189AB4)](https://xgboost.readthedocs.io/)
[![LightGBM](https://img.shields.io/badge/LightGBM-4.6.0-2980B9)](https://lightgbm.readthedocs.io/)
[![CatBoost](https://img.shields.io/badge/CatBoost-1.2.10-FFCC00)](https://catboost.ai/)
[![Optuna](https://img.shields.io/badge/Optuna-4.9.0-3EA7DC)](https://optuna.org/)

Mirror of the Kaggle notebook submission environment. Package versions are pinned to match a Kaggle notebook pip freeze so code runs identically when submitted to competitions. The NVIDIA variant also includes the RAPIDS stack (cuDF, cuML, CuPy) and a custom PyTorch wheel with Pascal support, fixing a defect in Kaggle's own stock wheel.

## License

The Dockerfiles, scripts, and documentation in this repository are licensed under the [MIT License](LICENSE). Built images incorporate third-party base images with their own upstream licenses.



