# LLM GPU Development Container
# Based on nvidia/cuda runtime + custom PyTorch wheel for wide GPU compatibility.
# PyTorch 2.11.0 (custom build), CUDA 12.8.1, Python 3.12, Ubuntu 24.04.
# Supports Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200), sm_60-sm_100.
# Requires host driver >= 560.x on Linux.
# =============================================================================
FROM nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04

ARG IMAGE_VERSION=dev
ARG WHEEL_URL=https://github.com/gperdrizet/docker-images/releases/download/pytorch-2.11.0-cu128-cp312/torch-2.11.0-cp312-cp312-linux_x86_64.whl
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.12 \
        python3.12-dev \
        python3-pip \
        screen \
        sudo \
        htop \
        bmon \
        curl \
        zstd \
        git \
        openssh-client && \
    mkdir -p /run/screen && chmod 777 /run/screen && \
    ln -sf /usr/bin/python3.12 /usr/bin/python && \
    ln -sf /usr/bin/python3.12 /usr/bin/python3 && \
    userdel $(getent passwd 1000 | cut -d: -f1) 2>/dev/null || true && \
    groupdel $(getent group 1000 | cut -d: -f1) 2>/dev/null || true && \
    groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc && \
    echo 'export HF_HOME="/home/vscode/.cache/huggingface"' >> /home/vscode/.bashrc && \
    mkdir -p /workspace && \
    rm -f /usr/lib/python3.12/EXTERNALLY-MANAGED && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install custom PyTorch wheel (Pascal through Blackwell, sm_60-sm_100)
RUN pip install --no-cache-dir --break-system-packages --root-user-action=ignore ${WHEEL_URL}

# Install Ollama server binary directly from latest release
RUN curl -fsSL https://github.com/ollama/ollama/releases/latest/download/ollama-linux-amd64.tar.zst \
        | tar -x --zstd -C /usr/local

# Copy and configure startup script
COPY motd.sh /usr/local/bin/motd.sh
RUN chmod +x /usr/local/bin/motd.sh && \
    echo 'source /usr/local/bin/motd.sh' >> /etc/bash.bashrc && \
    echo "${IMAGE_VERSION}" > /etc/image-version

# Copy our README to workspace
COPY README.md /workspace/README.md

# Copy requirements and install LLM Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --break-system-packages --root-user-action=ignore -r requirements.txt

# docker build -t gperdrizet/llms-gpu:latest .
# docker push gperdrizet/llms-gpu:latest
