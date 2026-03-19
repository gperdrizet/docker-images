# =============================================================================
# Stage 1: Build PyTorch from source
# =============================================================================
FROM nvcr.io/nvidia/cuda:12.6.3-cudnn-devel-ubuntu22.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

# Install minimal build dependencies
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
        git \
        ninja-build \
        cmake && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel

# Build PyTorch wheel for wide GPU compatibility (Pascal through Ada Lovelace)
# Use stable release tag to avoid bleeding-edge NCCL/CUDA incompatibilities
RUN mkdir -p /wheels && \
    git clone --depth 1 --branch v2.5.1 https://github.com/pytorch/pytorch /opt/pytorch && \
    cd /opt/pytorch && \
    git submodule sync && \
    git submodule update --init --recursive --depth 1 && \
    pip install --root-user-action=ignore -r requirements.txt && \
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
FROM nvcr.io/nvidia/cuda:12.6.3-cudnn-devel-ubuntu22.04

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

# Copy and install PyTorch wheel from builder stage
COPY --from=builder /wheels/*.whl /tmp/
RUN pip install --no-cache-dir --root-user-action=ignore /tmp/*.whl && \
    rm -rf /tmp/*.whl

# Install Ollama server binary
RUN curl -fsSL https://ollama.com/install.sh | sh

# Copy and configure startup script
COPY motd.sh /usr/local/bin/motd.sh
RUN chmod +x /usr/local/bin/motd.sh && \
    echo 'source /usr/local/bin/motd.sh' >> /etc/bash.bashrc

# Copy our README to workspace
COPY README.md /workspace/README.md

# Copy requirements and install LLM Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# docker build -t gperdrizet/llms-gpu:latest .
# docker push gperdrizet/llms-gpu:latest
