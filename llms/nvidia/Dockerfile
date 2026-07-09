# LLM GPU Development Container
# Based on nvidia/cuda runtime + custom PyTorch wheel for wide GPU compatibility.
# PyTorch 2.11.0 (custom build), CUDA 12.8.1, Python 3.12, Ubuntu 24.04.
# Supports Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200), sm_60-sm_100.
# Requires host driver >= 570.x on Linux.
# =============================================================================
FROM nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04@sha256:ac55d124da4882b497f732d8dfd9a702d5447a5f29d08d56da6f64f0a1eb34bc

LABEL org.opencontainers.image.source="https://github.com/gperdrizet/docker-images" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.authors="gperdrizet"

ARG IMAGE_VERSION=dev
ENV DEBIAN_FRONTEND=noninteractive
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/lib/x86_64-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Migrate CUDA APT signing key from legacy keyring to modern per-repo location
RUN if [ -f /etc/apt/trusted.gpg ]; then \
        cp /etc/apt/trusted.gpg /etc/apt/trusted.gpg.d/cuda-keyring.gpg && \
        rm -f /etc/apt/trusted.gpg; \
    fi && \
    chmod 1777 /tmp && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.12 \
        python3.12-dev \
        python3.12-venv \
        python3-pip \
        screen \
        sudo \
        htop \
        bmon \
        curl \
        zstd \
        git \
        openssh-client \
        libopenmpi3t64 \
        libcusparselt0 \
        libgomp1 && \
    mkdir -p /run/screen && chmod 777 /run/screen && \
    ln -sf /usr/bin/python3.12 /usr/bin/python && \
    ln -sf /usr/bin/python3.12 /usr/bin/python3 && \
    (userdel $(getent passwd 1000 | cut -d: -f1) 2>/dev/null || true) && \
    (groupdel $(getent group 1000 | cut -d: -f1) 2>/dev/null || true) && \
    groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    mkdir -p /home/vscode && chown -R vscode:vscode /home/vscode && \
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc && \
    echo 'export HF_HOME="/home/vscode/.cache/huggingface"' >> /home/vscode/.bashrc && \
    mkdir -p /workspace && \
    rm -f /usr/lib/python3.12/EXTERNALLY-MANAGED && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Install Ollama server binary directly from latest release
RUN curl -fsSL https://github.com/ollama/ollama/releases/latest/download/ollama-linux-amd64.tar.zst \
        | tar -x --zstd -C /usr/local

# Copy and configure startup script
COPY motd.sh /usr/local/bin/motd.sh
RUN chmod +x /usr/local/bin/motd.sh && \
    echo 'source /usr/local/bin/motd.sh' >> /etc/bash.bashrc

# Install all dependencies. torch is specified as a direct URL in requirements.txt so pip
# installs our custom wheel and satisfies the torch dep for all other packages without
# ever touching PyPI for torch. No nvidia-*-cu12 pip packages are pulled in.
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --break-system-packages --root-user-action=ignore -r requirements.txt

# Copy our README to workspace
COPY README.md README.md
RUN echo "${IMAGE_VERSION}" > /etc/image-version

# Validate torch import at build time
RUN python3 -c "import torch; print('torch', torch.__version__, 'OK')"

EXPOSE 8888 7860

# docker build -t gperdrizet/llms-nvidia:latest .
# docker push gperdrizet/llms-nvidia:latest
