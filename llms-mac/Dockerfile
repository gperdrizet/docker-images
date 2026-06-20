# LLM Mac (ARM64) Development Container
# Identical to llms-cpu but built for linux/arm64 (Apple Silicon).
# Runs natively on M1/M2/M3 Macs via Docker Desktop — no Rosetta emulation.
# Note: No GPU acceleration — Metal/MPS is not accessible inside Docker containers.
FROM python:3.12-slim

LABEL org.opencontainers.image.source="https://github.com/gperdrizet/docker-images" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.authors="gperdrizet"

ARG IMAGE_VERSION=dev

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        screen \
        sudo \
        htop \
        curl \
        git \
        build-essential \
        openssh-client \
        bmon \
        zstd && \
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

WORKDIR /workspace

# Install Ollama server binary for ARM64
RUN curl -fsSL https://github.com/ollama/ollama/releases/latest/download/ollama-linux-arm64.tar.zst \
        | tar -x --zstd -C /usr/local

RUN pip install --no-cache-dir --upgrade pip setuptools wheel

COPY motd.sh /usr/local/bin/motd.sh
COPY bash.bashrc /etc/bash.bashrc
RUN chmod +x /usr/local/bin/motd.sh && \
    echo "${IMAGE_VERSION}" > /etc/image-version

COPY README.md README.md

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Install PyTorch for ARM64 — pytorch.org/whl/cpu only has x86 wheels; PyPI has aarch64
RUN pip install --no-cache-dir --root-user-action=ignore torch torchvision

EXPOSE 8888 7860

# docker buildx build --platform linux/arm64 -t gperdrizet/llms-mac:latest .
# docker push gperdrizet/llms-mac:latest
