# LLM GPU Development Container
# Pre-built PyTorch wheel with wide GPU support (Pascal through Hopper, sm_60-sm_90)
# =============================================================================
FROM nvcr.io/nvidia/cuda:12.6.3-cudnn-devel-ubuntu22.04

ARG IMAGE_VERSION=dev
ENV DEBIAN_FRONTEND=noninteractive

# Install runtime packages (keeping build tools for llama.cpp etc.)
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.11 \
        python3.11-venv \
        python3.11-dev \
        python3-pip \
        screen \
        sudo \
        htop \
        bmon \
        curl \
        git \
        zstd \
        ninja-build \
        openssh-client \
        cmake && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    mkdir -p /run/screen && chmod 777 /run/screen && \
    groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc && \
    echo 'export HF_HOME="/home/vscode/.cache/huggingface"' >> /home/vscode/.bashrc && \
    mkdir -p /workspace && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel

# Install Ollama server binary
RUN curl -fsSL https://ollama.com/install.sh | sh

# Copy and configure startup script
COPY motd.sh /usr/local/bin/motd.sh
RUN chmod +x /usr/local/bin/motd.sh && \
    echo 'source /usr/local/bin/motd.sh' >> /etc/bash.bashrc && \
    echo "${IMAGE_VERSION}" > /etc/image-version

# Copy our README to workspace
COPY README.md /workspace/README.md

# Copy requirements and install LLM Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt && \
    pip uninstall -y torchvision torchaudio 2>/dev/null || true

# Install custom PyTorch wheel with Pascal+ support from GitHub release
# --force-reinstall ensures our wheel overwrites any torch pulled by dependencies
ARG WHEEL_URL=https://github.com/gperdrizet/docker-images/releases/download/pytorch-2.5.1-cu126/torch-2.5.1-cp311-cp311-linux_x86_64.whl
RUN pip install --no-cache-dir --force-reinstall ${WHEEL_URL}

# docker build -t gperdrizet/llms-gpu:latest .
# docker push gperdrizet/llms-gpu:latest
