# Data Science NVIDIA GPU Development Container
# Based on nvidia/cuda:12.8.1-runtime-ubuntu24.04.
# Adds GPU-accelerated XGBoost and CuPy on top of the standard data science stack.
# Supports Pascal (GTX 10xx) through Blackwell (RTX 50xx/B100/B200), sm_60-sm_100.
# Requires host driver >= 570.x on Linux.
FROM nvidia/cuda:12.8.1-runtime-ubuntu24.04

ARG IMAGE_VERSION=dev
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

COPY motd.sh /usr/local/bin/motd.sh
RUN chmod +x /usr/local/bin/motd.sh && \
    echo 'source /usr/local/bin/motd.sh' >> /etc/bash.bashrc && \
    echo "${IMAGE_VERSION}" > /etc/image-version

COPY README.md /workspace/README.md

COPY requirements.txt .
RUN pip install --no-cache-dir --break-system-packages --root-user-action=ignore --upgrade pip && \
    pip install --no-cache-dir --break-system-packages --root-user-action=ignore -r requirements.txt

# docker build -t gperdrizet/datascience-nvidia:latest .
# docker push gperdrizet/datascience-nvidia:latest
