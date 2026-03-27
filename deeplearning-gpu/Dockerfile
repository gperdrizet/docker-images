# Deep Learning GPU Development Container
# Pre-built PyTorch wheel with wide GPU support (Pascal through Hopper, sm_60-sm_90)
# =============================================================================
# Use NVIDIA's official TensorFlow 24.08 image with GPU support
# See here: https://docs.nvidia.com/deeplearning/frameworks/tensorflow-release-notes/rel-24-08.html
FROM nvcr.io/nvidia/tensorflow:24.08-tf2-py3

ARG IMAGE_VERSION=dev

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
    groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc && \
    rm -rf /workspace/docker-examples /workspace/nvidia-examples && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy and configure startup script
COPY motd.sh /usr/local/bin/motd.sh
RUN chmod +x /usr/local/bin/motd.sh && \
    echo 'source /usr/local/bin/motd.sh' >> /etc/bash.bashrc && \
    echo "${IMAGE_VERSION}" > /etc/image-version && \
    mv /workspace/README.md /workspace/NVIDIA_README.md 2>/dev/null || true

COPY README.md /workspace/README.md

# Upgrade pip and install requirements
COPY requirements.txt .
RUN pip install --no-cache-dir --root-user-action=ignore --upgrade pip && \
    pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Install custom PyTorch wheel with Pascal+ support from GitHub release
# Note: This image uses Python 3.10 (from TensorFlow base) - wheel must be cp310
# --force-reinstall ensures our wheel overwrites any torch pulled by dependencies
ARG WHEEL_URL=https://github.com/gperdrizet/docker-images/releases/download/pytorch-2.5.1-cu124-cp310/torch-2.5.1-cp310-cp310-linux_x86_64.whl
RUN pip install --no-cache-dir --root-user-action=ignore --force-reinstall ${WHEEL_URL}

# docker build -t gperdrizet/deeplearning-gpu:latest .
# docker push gperdrizet/deeplearning-gpu:latest