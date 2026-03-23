# =============================================================================
# Stage 1: Build PyTorch from source
# =============================================================================
FROM nvcr.io/nvidia/tensorflow:24.08-tf2-py3 AS builder

# Build PyTorch wheel for wide GPU compatibility (Pascal through Ada Lovelace)
# Use stable release tag to avoid bleeding-edge NCCL/CUDA incompatibilities
# Set explicit version to match tag (shallow clone breaks git-derived versioning)
RUN mkdir -p /wheels && \
    git clone --depth 1 --branch v2.5.1 https://github.com/pytorch/pytorch /opt/pytorch && \
    cd /opt/pytorch && \
    git submodule sync && \
    git submodule update --init --recursive --depth 1 && \
    pip install --root-user-action=ignore -r requirements.txt && \
    PYTORCH_BUILD_VERSION=2.5.1 \
    PYTORCH_BUILD_NUMBER=1 \
    MAX_JOBS=16 \
    BUILD_TEST=0 \
    USE_FBGEMM=0 \
    USE_KINETO=0 \
    USE_NUMPY=1 \
    TORCH_CUDA_ARCH_LIST="6.0;6.1;7.0;7.5;8.0;8.6;8.9;9.0" \
    python setup.py bdist_wheel -d /wheels

# =============================================================================
# Stage 2: Final image (no PyTorch source bloat)
# =============================================================================
# Use NVIDIA's official TensorFlow 24.08 image with GPU support
# See here: https://docs.nvidia.com/deeplearning/frameworks/tensorflow-release-notes/rel-24-08.html
FROM nvcr.io/nvidia/tensorflow:24.08-tf2-py3

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
    groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc && \
    rm -rf /workspace/docker-examples /workspace/nvidia-examples && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy and configure startup script
COPY motd.sh /usr/local/bin/motd.sh
RUN chmod +x /usr/local/bin/motd.sh && \
    echo 'source /usr/local/bin/motd.sh' >> /etc/bash.bashrc && \
    mv /workspace/README.md /workspace/NVIDIA_README.md 2>/dev/null || true

COPY README.md /workspace/README.md

# Upgrade pip and install requirements
COPY requirements.txt .
RUN pip install --no-cache-dir --root-user-action=ignore --upgrade pip && \
    pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Copy and install custom PyTorch wheel from builder stage AFTER requirements
# This overwrites any torch pulled in by dependencies with our Pascal-compatible build
COPY --from=builder /wheels/*.whl /tmp/
RUN pip install --no-cache-dir --root-user-action=ignore --force-reinstall /tmp/*.whl && \
    rm -rf /tmp/*.whl

# docker build -t gperdrizet/deeplearning-gpu:latest .
# docker push gperdrizet/deeplearning-gpu:latest