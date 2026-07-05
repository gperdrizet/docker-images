# Building for ARM64 (macOS)

The Mac images are built for `linux/arm64` using Docker buildx with QEMU emulation. You must create a persistent builder before building locally.

## Setup

```bash
# Create a builder using the docker-container driver
docker buildx create --name mybuilder --driver docker-container --use

# Verify arm64 is listed under platforms
docker buildx inspect --bootstrap
```

Then build with:

```bash
make build-datascience-mac VERSION=dev
```

## Troubleshooting

If a build fails with QEMU errors, reset the emulator registration and recreate the builder:

```bash
# Reset QEMU emulator registration
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

# Remove and recreate the builder
docker buildx rm mybuilder || true
docker buildx create --name mybuilder --driver docker-container --use
```
