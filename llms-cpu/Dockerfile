# Use Python 3.11 slim image for lightweight CPU-only LLM development
FROM python:3.11-slim

# Install system packages in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        screen \
        sudo \
        htop \
        curl \
        git \
        build-essential \
        openssh-client \
        zstd && \
    # Create screen run directory with proper permissions
    mkdir -p /run/screen && chmod 777 /run/screen && \
    # Create vscode group and user for devcontainer
    groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    # Add .local/bin to vscode user's PATH
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc && \
    # Set Hugging Face cache directory
    echo 'export HF_HOME="/home/vscode/.cache/huggingface"' >> /home/vscode/.bashrc && \
    # Clean up apt cache to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Ollama server binary
RUN curl -fsSL https://ollama.com/install.sh | sh

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Copy and configure startup script and custom bash.bashrc
COPY motd.sh /usr/local/bin/motd.sh
COPY bash.bashrc /etc/bash.bashrc
RUN chmod +x /usr/local/bin/motd.sh

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Install PyTorch CPU version
RUN pip install --no-cache-dir --root-user-action=ignore torch torchvision --index-url https://download.pytorch.org/whl/cpu

# docker build -t gperdrizet/llms-cpu:latest .
# docker push gperdrizet/llms-cpu:latest
