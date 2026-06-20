# Deep Learning Mac (ARM64) Development Container
# Identical to deeplearning-cpu but built for linux/arm64 (Apple Silicon).
# Runs natively on M1/M2/M3 Macs via Docker Desktop — no Rosetta emulation.
# Note: No GPU acceleration — Metal/MPS is not accessible inside Docker containers.
FROM python:3.12-slim

LABEL org.opencontainers.image.source="https://github.com/gperdrizet/docker-images" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.authors="gperdrizet"

ARG IMAGE_VERSION=dev
ENV DEBIAN_FRONTEND=noninteractive

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
    mkdir -p /workspace && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

COPY motd.sh /usr/local/bin/motd.sh
COPY bash.bashrc /etc/bash.bashrc
RUN chmod +x /usr/local/bin/motd.sh && \
    echo "${IMAGE_VERSION}" > /etc/image-version

COPY README.md README.md

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --root-user-action=ignore --upgrade pip && \
    pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Install PyTorch for ARM64 — pytorch.org/whl/cpu only has x86 wheels; PyPI has aarch64
RUN pip install --no-cache-dir --root-user-action=ignore torch torchvision

EXPOSE 8888 6006

# docker buildx build --platform linux/arm64 -t gperdrizet/deeplearning-mac:latest .
# docker push gperdrizet/deeplearning-mac:latest
