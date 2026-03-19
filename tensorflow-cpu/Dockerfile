# Use Google's official TensorFlow 2.16.1 image with GPU support
# See here: https://hub.docker.com/r/tensorflow/tensorflow/tags?name=2.16.1
FROM tensorflow/tensorflow:2.16.1-jupyter

# Install all OS packages in a single layer, clean up apt cache to reduce image size
# This layer changes infrequently and should be cached
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        openssh-client \
        wget \
        screen \
        python3-pip \
        sudo && \
    rm -rf /var/lib/apt/lists/*

# Create vscode group and user for devcontainer (system configuration, changes rarely)
RUN groupadd --gid 1000 vscode && \
    useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    # Add .local/bin to vscode user's PATH
    echo 'export PATH="/home/vscode/.local/bin:$PATH"' >> /home/vscode/.bashrc

# Create symlinks for python and pip (system configuration, changes rarely)
RUN ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/local/bin/pip3 /usr/local/bin/pip

# Upgrade pip (changes infrequently)
# Note: First upgrade without --root-user-action since base image pip may not support it
RUN pip3 install --no-cache-dir --upgrade pip

# Copy and configure startup script and custom bash.bashrc (removes Google MOTD)
COPY motd.sh /usr/local/bin/motd.sh
COPY bash.bashrc /etc/bash.bashrc
RUN chmod +x /usr/local/bin/motd.sh

# Copy requirements last - this file changes most frequently
COPY requirements.txt .

# Install Python dependencies in a single layer
# Install tornado and notebook first - jupyter_tensorboard requires them during build
# Use notebook<7 because jupyter_tensorboard requires notebook.base (removed in v7)
# Use --no-build-isolation for jupyter_tensorboard so it can find these dependencies
# (pip's build isolation creates a clean env that excludes installed packages)
RUN pip3 install --no-cache-dir --root-user-action=ignore tornado "notebook<7" && \
    pip3 install --no-cache-dir --root-user-action=ignore --no-build-isolation jupyter_tensorboard && \
    pip3 install --no-cache-dir --root-user-action=ignore -r requirements.txt

# docker build -t gperdrizet/tensorflow-cpu:latest .
# docker push gperdrizet/tensorflow-cpu:latest