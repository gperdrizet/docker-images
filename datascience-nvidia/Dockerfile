# Data Science NVIDIA GPU Development Container
# Based on nvidia/cuda:12.8.1-runtime-ubuntu24.04.
# Adds GPU-accelerated XGBoost and CuPy on top of the standard data science stack.
# Supports Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200), sm_60-sm_100.
# Pre-built CuPy wheel with wide GPU support
# Requires host driver >= 570.x on Linux.
FROM nvidia/cuda:12.8.1-runtime-ubuntu24.04

LABEL org.opencontainers.image.source="https://github.com/gperdrizet/docker-images" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.authors="gperdrizet"

ARG IMAGE_VERSION=dev
ENV DEBIAN_FRONTEND=noninteractive

# Update and install common utilities, create vscode user, and clean up apt caches
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.12 \
        python3.12-dev \
        python3-pip \
        procps \
        screen \
        sudo \
        htop \
        bmon \
        curl \
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
    mkdir -p /workspace && \
    rm -f /usr/lib/python3.12/EXTERNALLY-MANAGED && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Copy and configure startup script
COPY motd.sh /usr/local/bin/motd.sh
RUN chmod +x /usr/local/bin/motd.sh && \
    echo 'source /usr/local/bin/motd.sh' >> /etc/bash.bashrc && \
    echo "${IMAGE_VERSION}" > /etc/image-version

COPY README.md README.md

# Upgrade pip
# --ignore-installed: base image pip was installed by apt (no RECORD file), skip uninstall
RUN pip install --no-cache-dir --root-user-action=ignore --upgrade pip --ignore-installed

# Install custom CuPy wheel with Pascal+ support from GitHub release
# Note: Python 3.12 (nvidia/cuda:12.8.1-runtime-ubuntu24.04) — wheel must be cp312
# --force-reinstall: ensure our wheel takes precedence over any PyPI cupy
# --no-deps: preserve existing nvidia-*-cu12 CUDA packages from the base image
ARG CUPY_WHEEL_URL=https://github.com/gperdrizet/docker-images/releases/download/cupy-13.6.0-cu128-cp312/cupy-13.6.0-cp312-cp312-linux_x86_64.whl
RUN pip install --no-cache-dir --root-user-action=ignore --force-reinstall --no-deps ${CUPY_WHEEL_URL}

# Install remaining Python dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Validate GPU import at build time
RUN python3 -c "import cupy; print('cupy', cupy.__version__, 'OK')"

EXPOSE 8888

# docker build -t gperdrizet/datascience-nvidia:latest .
# docker push gperdrizet/datascience-nvidia:latest