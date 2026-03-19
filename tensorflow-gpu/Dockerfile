# Use NVIDIA's official TensorFlow 24.06 image with GPU support
# See here: https://docs.nvidia.com/deeplearning/frameworks/tensorflow-release-notes/rel-24-06.html
FROM nvcr.io/nvidia/tensorflow:24.06-tf2-py3

# Install system packages, create vscode user, and clean up in a single layer
# This reduces image size and layer count
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        screen \
        sudo && \
    # Create screen run directory with proper permissions
    mkdir -p /run/screen && chmod 777 /run/screen && \
    # Create vscode group and user for devcontainer
    groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    # Add .local/bin to vscode user's PATH
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc && \
    # Clean up apt cache to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy and configure startup script (changes infrequently)
COPY motd.sh /usr/local/bin/motd.sh
RUN chmod +x /usr/local/bin/motd.sh && \
    echo 'source /usr/local/bin/motd.sh' >> /etc/bash.bashrc

# Copy requirements and install Python dependencies
# Placed near the end since requirements.txt changes more frequently
COPY requirements.txt .
# Note: First upgrade without --root-user-action since base image pip may not support it
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# docker build -t gperdrizet/tensorflow-gpu:latest .
# docker push gperdrizet/tensorflow-gpu:latest