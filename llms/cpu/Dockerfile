# Use Python 3.12 slim image for lightweight CPU-only LLM development
FROM python:3.12-slim@sha256:423ed6ab25b1921a477529254bfeeabf5855151dc2c3141699a1bfc852199fbf

LABEL org.opencontainers.image.source="https://github.com/gperdrizet/docker-images" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.authors="gperdrizet"

ARG IMAGE_VERSION=dev

# Install system packages in a single layer
RUN chmod 1777 /tmp && \
    apt-get update && \
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
    # Create screen run directory with proper permissions
    mkdir -p /run/screen && chmod 777 /run/screen && \
    # Remove any pre-existing uid/gid 1000 account before recreating vscode user
    (userdel $(getent passwd 1000 | cut -d: -f1) 2>/dev/null || true) && \
    (groupdel $(getent group 1000 | cut -d: -f1) 2>/dev/null || true) && \
    # Create vscode group and user for devcontainer
    groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    mkdir -p /home/vscode && chown -R vscode:vscode /home/vscode && \
    # Add .local/bin to vscode user's PATH
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc && \
    # Set Hugging Face cache directory
    echo 'export HF_HOME="/home/vscode/.cache/huggingface"' >> /home/vscode/.bashrc && \
    mkdir -p /workspace && \
    # Clean up apt cache to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Install Ollama server binary directly from latest release
RUN curl -fsSL https://github.com/ollama/ollama/releases/latest/download/ollama-linux-amd64.tar.zst \
        | tar -x --zstd -C /usr/local

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# Copy and configure startup script and custom bash.bashrc
COPY motd.sh /usr/local/bin/motd.sh
COPY bash.bashrc /etc/bash.bashrc
RUN chmod +x /usr/local/bin/motd.sh

# Copy requirements and install Python dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Install PyTorch CPU version
RUN pip install --no-cache-dir --root-user-action=ignore torch torchvision --index-url https://download.pytorch.org/whl/cpu

# Copy our README to workspace
COPY README.md README.md
RUN echo "${IMAGE_VERSION}" > /etc/image-version

EXPOSE 8888 7860

# docker build -t gperdrizet/llms-cpu:latest .
# docker push gperdrizet/llms-cpu:latest
