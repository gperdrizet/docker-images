# Deep Learning GPU Development Container
# Pre-built PyTorch wheel with wide GPU support (Pascal through Blackwell, sm_60-sm_100)
# =============================================================================
# Use NVIDIA's official TensorFlow 25.02 image with GPU support
# Note: 25.02 is the final NVIDIA TF NGC container release.
# See here: https://docs.nvidia.com/deeplearning/frameworks/tensorflow-release-notes/rel-25-02.html
FROM nvcr.io/nvidia/tensorflow:25.02-tf2-py3

LABEL org.opencontainers.image.source="https://github.com/gperdrizet/docker-images" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.authors="gperdrizet"

ARG IMAGE_VERSION=dev

# Update and install common utilities, create vscode user, and clean up apt caches
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        screen \
        sudo \
        htop \
        bmon \
        curl \
        openssh-client \
        git && \
    mkdir -p /run/screen && chmod 777 /run/screen && \
    userdel $(getent passwd 1000 | cut -d: -f1) 2>/dev/null || true && \
    groupdel $(getent group 1000 | cut -d: -f1) 2>/dev/null || true && \
    groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc && \
    echo 'export HF_HOME="/home/vscode/.cache/huggingface"' >> /home/vscode/.bashrc && \
    rm -rf /workspace/docker-examples /workspace/nvidia-examples && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Copy and configure startup script
COPY motd.sh /usr/local/bin/motd.sh
RUN chmod +x /usr/local/bin/motd.sh && \
    echo 'source /usr/local/bin/motd.sh' >> /etc/bash.bashrc && \
    mv /workspace/README.md /workspace/NVIDIA_README.md 2>/dev/null || true

# Upgrade pip
# --ignore-installed: base image pip was installed by apt (no RECORD file), skip uninstall
RUN pip install --no-cache-dir --root-user-action=ignore --upgrade pip --ignore-installed

# Install custom PyTorch wheel with Pascal+ support from GitHub release
# Note: Python 3.12 (TensorFlow 25.02 base) — wheel must be cp312
# --force-reinstall: overwrite any torch pulled in by requirements dependencies
# --no-deps: preserve existing nvidia-*-cu12 CUDA packages from the base image
ARG PYTORCH_WHEEL_URL=https://github.com/gperdrizet/docker-images/releases/download/pytorch-2.11.0-cu128-cp312/torch-2.11.0-cp312-cp312-linux_x86_64.whl
RUN pip install --no-cache-dir --root-user-action=ignore --force-reinstall --no-deps ${PYTORCH_WHEEL_URL}

# Install custom CuPy wheel with Pascal+ support from GitHub release
# Note: Python 3.12 (TensorFlow 25.02 base) — wheel must be cp312
# --force-reinstall: ensure our wheel takes precedence over any PyPI cupy
# --no-deps: preserve existing nvidia-*-cu12 CUDA packages from the base image
# fastrlock: CuPy dependency not installed by --no-deps, safe to pull from PyPI
ARG CUPY_WHEEL_URL=https://github.com/gperdrizet/docker-images/releases/download/cupy-13.6.0-cu128-cp312/cupy-13.6.0-cp312-cp312-linux_x86_64.whl
RUN pip install --no-cache-dir --root-user-action=ignore fastrlock && \
    pip install --no-cache-dir --root-user-action=ignore --force-reinstall --no-deps ${CUPY_WHEEL_URL}

# Install remaining Python dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

COPY README.md README.md
RUN echo "${IMAGE_VERSION}" > /etc/image-version

# Validate GPU imports at build time
RUN python3 -c "import torch; print('torch', torch.__version__, 'OK')"
RUN python3 -c "import cupy; print('cupy', cupy.__version__, 'OK')"

EXPOSE 8888 6006

# docker build -t gperdrizet/deeplearning-nvidia:latest .
# docker push gperdrizet/deeplearning-nvidia:latest