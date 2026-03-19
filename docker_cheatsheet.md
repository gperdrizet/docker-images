# Docker cheatsheet

## 1. Fix output from `docker ps`

Edit your `~/.docker/config.json`, add:

```json
"psFormat": "table {{.Names}}\\t{{truncate .Image 50}}\\t{{.Status}}"
```

Available fields are:

| Field | Description |
|-------|-------------|
| `{{.ID}}` | Container ID |
| `{{.Image}}` | Image name |
| `{{.Command}}` | The command that started the container |
| `{{.RunningFor}}` | Elapsed time since the container was started |
| `{{.Status}}` | Container status (e.g., "Up 10 minutes", "Exited (0) 2 hours ago") |
| `{{.Ports}}` | Exposed ports |
| `{{.Names}}` | Container names |
| `{{.CreatedAt}}` | Time when the container was created |
| `{{.Labels}}` | All labels assigned to the container |

## 2. Controlling containers

### 2.1. Run a container indefinitely in the background

```text
docker run -d gperdrizet/deeplearning-gpu tail -f /dev/null
```

The `-d` is for detach, give you your prompt back. The tail command can be anything that runs forever.

### 2.2. Run and attach to a container

```text
docker run -it gperdrizet/deeplearning-gpu
```

### 2.3. Stop a container

```text
docker stop ID_or_name
```

### 2.4. Remove a container

```text
docker rm ID_or_name
```

### 2.5. Remove all stopped containers

```text
docker container prune
```

## 3. Moving Docker's data directory

By default, Docker stores images, containers, and volumes in `/var/lib/docker`. To move this to a different drive (e.g., faster SSD, more space):

### 3.1. Stop Docker and running containers

```bash
# Stop containers gracefully first
docker stop $(docker ps -q)

# Stop Docker daemon
sudo systemctl stop docker docker.socket containerd
```

### 3.2. Configure new data root

```bash
sudo mkdir -p /etc/docker
echo '{"data-root": "/path/to/new/docker"}' | sudo tee /etc/docker/daemon.json
```

### 3.3. Move existing data

```bash
sudo mv /var/lib/docker /path/to/new/docker
```

### 3.4. Restart Docker

```bash
sudo systemctl start docker
```

### 3.5. Verify

```bash
docker info | grep "Docker Root Dir"
```

## 4. Multi-stage builds to reduce image size

Docker images are made of layers. Each `RUN` command creates a layer, and layers are additive—even if you delete files in a later layer, the space is still consumed in the earlier layer.

### 4.1. The problem with single-stage builds

```dockerfile
FROM cuda:devel          # Layer 1: 12 GB
RUN apt install cmake... # Layer 2: +500 MB (build tools)
RUN git clone myproject  # Layer 3: +2 GB (source code)
RUN make && make install # Layer 4: +1 GB (compiled binaries)
RUN rm -rf /src          # Layer 5: +0 (files gone, but Layer 3 still exists!)
# Total: ~15.5 GB
```

### 4.2. Multi-stage solution

Use separate stages: one for building, one for the final image. Only explicitly copied files make it to the final image.

```dockerfile
# Stage 1: Builder (temporary, discarded after build)
FROM cuda:devel AS builder
RUN apt install cmake ninja-build...
RUN git clone myproject /src
WORKDIR /src
RUN cmake -B build && cmake --build build
# Build artifacts now in /src/build/

# Stage 2: Runtime (final image)
FROM cuda:runtime
COPY --from=builder /src/build/myapp /usr/local/bin/
# Only the compiled binary is copied - no source, no build tools
```

### 4.3. Key benefits

| Approach | Image contains | Typical savings |
|----------|----------------|-----------------|
| Single-stage | Source + build tools + artifacts | — |
| Multi-stage | Only runtime artifacts | 30-60% smaller |

### 4.4. Building Python wheels

For Python projects, build a wheel in the builder stage and install it in the final stage:

```dockerfile
# Stage 1: Build wheel
FROM python:3.11 AS builder
RUN pip install build
COPY . /src
RUN python -m build --wheel -o /wheels /src

# Stage 2: Install wheel
FROM python:3.11-slim
COPY --from=builder /wheels/*.whl /tmp/
RUN pip install /tmp/*.whl && rm /tmp/*.whl
```

### 4.5. When to use `-devel` vs `-runtime` base images

| Image type | Contains | Use case |
|------------|----------|----------|
| `-runtime` | Runtime libraries only | Running pre-compiled code |
| `-devel` | Runtime + headers + compilers | Building CUDA code (nvcc needed) |

If users need to compile CUDA code at runtime (e.g., building llama.cpp), use `-devel` as the final base. Otherwise, `-runtime` saves ~6 GB.
