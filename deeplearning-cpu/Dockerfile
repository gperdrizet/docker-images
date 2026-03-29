# Deep Learning CPU Development Container
# Based on official TensorFlow image - CPU only, compatible with any machine.
# TensorFlow 2.17.0, Python 3.12, Ubuntu 22.04
FROM tensorflow/tensorflow:2.17.0

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
    mkdir -p /workspace && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy and configure startup script and custom bash.bashrc
COPY motd.sh /usr/local/bin/motd.sh
COPY bash.bashrc /etc/bash.bashrc
RUN chmod +x /usr/local/bin/motd.sh && \
    echo "${IMAGE_VERSION}" > /etc/image-version

COPY README.md /workspace/README.md

# Upgrade pip and install requirements
COPY requirements.txt .
RUN pip install --no-cache-dir --root-user-action=ignore --upgrade pip && \
    pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Install PyTorch CPU version
RUN pip install --no-cache-dir --root-user-action=ignore torch torchvision --index-url https://download.pytorch.org/whl/cpu

# docker build -t gperdrizet/deeplearning-cpu:latest .
# docker push gperdrizet/deeplearning-cpu:latest