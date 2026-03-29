# LLM GPU Development Container
# Based on NVIDIA PyTorch NGC container - no custom wheel build needed.
# PyTorch 2.7.0a0, CUDA 12.8.1, Python 3.12, Ubuntu 24.04, Blackwell-optimized.
# Requires host driver >= 570.x
# =============================================================================
FROM nvcr.io/nvidia/pytorch:25.03-py3

ARG IMAGE_VERSION=dev
ENV DEBIAN_FRONTEND=noninteractive

# Install additional runtime packages not in the NGC base
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        screen \
        sudo \
        htop \
        bmon \
        zstd \
        openssh-client && \
    mkdir -p /run/screen && chmod 777 /run/screen && \
    userdel $(getent passwd 1000 | cut -d: -f1) 2>/dev/null || true && \
    groupdel $(getent group 1000 | cut -d: -f1) 2>/dev/null || true && \
    groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc && \
    echo 'export HF_HOME="/home/vscode/.cache/huggingface"' >> /home/vscode/.bashrc && \
    mkdir -p /workspace && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip setuptools wheel

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
# PyTorch is already pre-installed in the NGC base image
COPY requirements.txt .
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# docker build -t gperdrizet/llms-gpu:latest .
# docker push gperdrizet/llms-gpu:latest
