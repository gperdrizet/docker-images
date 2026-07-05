.PHONY: \
        build-deeplearning-nvidia build-deeplearning-cpu build-deeplearning-mac \
        build-llms-nvidia build-llms-cpu build-llms-mac \
        build-datascience-nvidia build-datascience-cpu build-datascience-mac \
        build-kaggle-nvidia build-kaggle-cpu build-kaggle-mac \
        build-deeplearning build-llms build-datascience build-kaggle build-all \
        push-deeplearning-nvidia push-deeplearning-cpu push-deeplearning-mac \
        push-llms-nvidia push-llms-cpu push-llms-mac \
        push-datascience-nvidia push-datascience-cpu push-datascience-mac \
        push-kaggle-nvidia push-kaggle-cpu push-kaggle-mac \
        push-deeplearning push-llms push-datascience push-kaggle push-all all \
        test-deeplearning-cpu test-deeplearning-nvidia test-deeplearning-mac \
        test-llms-cpu test-llms-nvidia test-llms-mac \
        test-datascience-cpu test-datascience-nvidia test-datascience-mac \
        test-kaggle-cpu test-kaggle-nvidia test-kaggle-mac \
        test-cpu test-nvidia test-mac test-all \
        update-readme-deeplearning-nvidia update-readme-deeplearning-cpu update-readme-deeplearning-mac \
        update-readme-llms-nvidia update-readme-llms-cpu update-readme-llms-mac \
        update-readme-datascience-nvidia update-readme-datascience-cpu update-readme-datascience-mac \
        update-readme-kaggle-nvidia update-readme-kaggle-cpu update-readme-kaggle-mac \
        update-readme-all \
        wheel-deeplearning-nvidia \
        extract-wheel-deeplearning-nvidia \
		wheel-datascience-nvidia \
		extract-wheel-datascience-nvidia \
		buildx-builder base-digests

# Version - for local builds, defaults to the most recent git tag (e.g. v4.1.0 -> 4.1.0).
# CI passes VERSION explicitly via workflow_dispatch input; tags are created by CI after a
# successful push, so the tag always reflects a verified release.
# Override locally with: make build-all VERSION=4.1.0
VERSION ?= $(shell git describe --tags --abbrev=0 2>/dev/null | sed 's/^v//' | grep . || echo dev)

# DockerHub credentials (set via environment variables or .env file)
DOCKERHUB_USERNAME ?= gperdrizet
DOCKERHUB_TOKEN ?=

# Persistent buildx builder for ARM64 (mac) builds. Pinning the builder explicitly
# prevents builds from attaching to whatever builder happens to be "current" —
# ephemeral CI builders being torn down mid-build killed in-flight builds with
# gRPC graceful_stop errors. The persistent builder also keeps a local BuildKit
# layer cache between runs. Create once with: make buildx-builder
BUILDX_BUILDER ?= mybuilder
CACHE_BUST     ?= 1

# Image names
DEEPLEARNING_NVIDIA_IMAGE := gperdrizet/deeplearning-nvidia
DEEPLEARNING_CPU_IMAGE    := gperdrizet/deeplearning-cpu
LLMS_NVIDIA_IMAGE         := gperdrizet/llms-nvidia
LLMS_CPU_IMAGE            := gperdrizet/llms-cpu
DEEPLEARNING_MAC_IMAGE    := gperdrizet/deeplearning-mac
LLMS_MAC_IMAGE            := gperdrizet/llms-mac
DATASCIENCE_NVIDIA_IMAGE  := gperdrizet/datascience-nvidia
DATASCIENCE_CPU_IMAGE     := gperdrizet/datascience-cpu
DATASCIENCE_MAC_IMAGE     := gperdrizet/datascience-mac
KAGGLE_NVIDIA_IMAGE       := gperdrizet/kaggle-nvidia
KAGGLE_CPU_IMAGE          := gperdrizet/kaggle-cpu
KAGGLE_MAC_IMAGE          := gperdrizet/kaggle-mac

# ─── Build targets ────────────────────────────────────────────────────────────

# Ensure the persistent ARM64 builder exists (no-op if it already does)
buildx-builder:
	@docker buildx inspect $(BUILDX_BUILDER) > /dev/null 2>&1 || \
		docker buildx create --name $(BUILDX_BUILDER) --driver docker-container \
			--driver-opt network=host --bootstrap

# Print current upstream digests for all base images (for bumping FROM pins)
base-digests:
	@for ref in python:3.12-slim \
	            nvidia/cuda:12.8.1-runtime-ubuntu24.04 \
	            nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04 \
	            nvcr.io/nvidia/tensorflow:25.02-tf2-py3; do \
		printf '%s => ' "$$ref"; \
		docker buildx imagetools inspect "$$ref" 2>/dev/null | grep -m1 Digest | awk '{print $$2}'; \
	done

# deeplearning
build-deeplearning-nvidia:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) --shm-size=16g \
		-t $(DEEPLEARNING_NVIDIA_IMAGE):$(VERSION) -t $(DEEPLEARNING_NVIDIA_IMAGE):latest ./deeplearning-nvidia

build-deeplearning-cpu:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		-t $(DEEPLEARNING_CPU_IMAGE):$(VERSION) -t $(DEEPLEARNING_CPU_IMAGE):latest ./deeplearning-cpu

build-deeplearning-mac: buildx-builder
	DOCKER_BUILDKIT=1 docker buildx build --builder $(BUILDX_BUILDER) --platform linux/arm64 --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		--cache-from type=registry,ref=$(DEEPLEARNING_MAC_IMAGE):buildcache \
		--cache-from type=registry,ref=$(DEEPLEARNING_MAC_IMAGE):latest \
		--cache-to type=registry,ref=$(DEEPLEARNING_MAC_IMAGE):buildcache,mode=max \
		--load -t $(DEEPLEARNING_MAC_IMAGE):$(VERSION) -t $(DEEPLEARNING_MAC_IMAGE):latest ./deeplearning-mac

build-deeplearning: build-deeplearning-nvidia build-deeplearning-cpu build-deeplearning-mac

# llms
build-llms-nvidia:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) --shm-size=16g \
		-t $(LLMS_NVIDIA_IMAGE):$(VERSION) -t $(LLMS_NVIDIA_IMAGE):latest ./llms-nvidia

build-llms-cpu:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		-t $(LLMS_CPU_IMAGE):$(VERSION) -t $(LLMS_CPU_IMAGE):latest ./llms-cpu

build-llms-mac: buildx-builder
	DOCKER_BUILDKIT=1 docker buildx build --builder $(BUILDX_BUILDER) --platform linux/arm64 --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		--cache-from type=registry,ref=$(LLMS_MAC_IMAGE):buildcache \
		--cache-from type=registry,ref=$(LLMS_MAC_IMAGE):latest \
		--cache-to type=registry,ref=$(LLMS_MAC_IMAGE):buildcache,mode=max \
		--load -t $(LLMS_MAC_IMAGE):$(VERSION) -t $(LLMS_MAC_IMAGE):latest ./llms-mac

build-llms: build-llms-nvidia build-llms-cpu build-llms-mac

# datascience
build-datascience-nvidia:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		-t $(DATASCIENCE_NVIDIA_IMAGE):$(VERSION) -t $(DATASCIENCE_NVIDIA_IMAGE):latest ./datascience-nvidia

build-datascience-cpu:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		-t $(DATASCIENCE_CPU_IMAGE):$(VERSION) -t $(DATASCIENCE_CPU_IMAGE):latest ./datascience-cpu

build-datascience-mac: buildx-builder
	DOCKER_BUILDKIT=1 docker buildx build --builder $(BUILDX_BUILDER) --platform linux/arm64 --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		--cache-from type=registry,ref=$(DATASCIENCE_MAC_IMAGE):buildcache \
		--cache-from type=registry,ref=$(DATASCIENCE_MAC_IMAGE):latest \
		--cache-to type=registry,ref=$(DATASCIENCE_MAC_IMAGE):buildcache,mode=max \
		--load -t $(DATASCIENCE_MAC_IMAGE):$(VERSION) -t $(DATASCIENCE_MAC_IMAGE):latest ./datascience-mac

build-datascience: build-datascience-nvidia build-datascience-cpu build-datascience-mac

# kaggle
build-kaggle-nvidia:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) --build-arg CACHE_BUST=$(CACHE_BUST) \
		-t $(KAGGLE_NVIDIA_IMAGE):$(VERSION) -t $(KAGGLE_NVIDIA_IMAGE):latest ./kaggle-nvidia

build-kaggle-cpu:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		-t $(KAGGLE_CPU_IMAGE):$(VERSION) -t $(KAGGLE_CPU_IMAGE):latest ./kaggle-cpu

build-kaggle-mac: buildx-builder
	DOCKER_BUILDKIT=1 docker buildx build --builder $(BUILDX_BUILDER) --platform linux/arm64 --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		--cache-from type=registry,ref=$(KAGGLE_MAC_IMAGE):buildcache \
		--cache-from type=registry,ref=$(KAGGLE_MAC_IMAGE):latest \
		--cache-to type=registry,ref=$(KAGGLE_MAC_IMAGE):buildcache,mode=max \
		--load -t $(KAGGLE_MAC_IMAGE):$(VERSION) -t $(KAGGLE_MAC_IMAGE):latest ./kaggle-mac

build-kaggle: build-kaggle-nvidia build-kaggle-cpu build-kaggle-mac

build-all: build-deeplearning build-llms build-datascience build-kaggle

# ─── Test targets ─────────────────────────────────────────────────────────────

test-deeplearning-cpu:
	@bash ./tests/test-deeplearning-cpu.sh $(DEEPLEARNING_CPU_IMAGE):$(VERSION)

test-deeplearning-nvidia:
	@bash ./tests/test-deeplearning-nvidia.sh $(DEEPLEARNING_NVIDIA_IMAGE):$(VERSION)

test-llms-cpu:
	@bash ./tests/test-llms-cpu.sh $(LLMS_CPU_IMAGE):$(VERSION)

test-llms-nvidia:
	@bash ./tests/test-llms-nvidia.sh $(LLMS_NVIDIA_IMAGE):$(VERSION)

test-datascience-cpu:
	@bash ./tests/test-datascience-cpu.sh $(DATASCIENCE_CPU_IMAGE):$(VERSION)

test-datascience-nvidia:
	@bash ./tests/test-datascience-nvidia.sh $(DATASCIENCE_NVIDIA_IMAGE):$(VERSION)

test-datascience-mac:
	@bash ./tests/test-datascience-mac.sh $(DATASCIENCE_MAC_IMAGE):$(VERSION)

test-deeplearning-mac:
	@bash ./tests/test-deeplearning-mac.sh $(DEEPLEARNING_MAC_IMAGE):$(VERSION)

test-llms-mac:
	@bash ./tests/test-llms-mac.sh $(LLMS_MAC_IMAGE):$(VERSION)

test-kaggle-cpu:
	@bash ./tests/test-kaggle-cpu.sh $(KAGGLE_CPU_IMAGE):$(VERSION)

test-kaggle-nvidia:
	@bash ./tests/test-kaggle-nvidia.sh $(KAGGLE_NVIDIA_IMAGE):$(VERSION)

test-kaggle-mac:
	@bash ./tests/test-kaggle-mac.sh $(KAGGLE_MAC_IMAGE):$(VERSION)

test-cpu:    test-deeplearning-cpu test-llms-cpu test-datascience-cpu test-kaggle-cpu
test-nvidia: test-deeplearning-nvidia test-llms-nvidia test-datascience-nvidia test-kaggle-nvidia
test-mac:    test-datascience-mac test-deeplearning-mac test-llms-mac test-kaggle-mac
test-all:    test-cpu test-nvidia test-mac

# ─── Push targets ─────────────────────────────────────────────────────────────

push-deeplearning-nvidia:
	docker push $(DEEPLEARNING_NVIDIA_IMAGE):$(VERSION)
	docker push $(DEEPLEARNING_NVIDIA_IMAGE):latest

push-deeplearning-cpu:
	docker push $(DEEPLEARNING_CPU_IMAGE):$(VERSION)
	docker push $(DEEPLEARNING_CPU_IMAGE):latest

push-deeplearning-mac:
	docker push $(DEEPLEARNING_MAC_IMAGE):$(VERSION)
	docker push $(DEEPLEARNING_MAC_IMAGE):latest

push-deeplearning: push-deeplearning-nvidia push-deeplearning-cpu push-deeplearning-mac

push-llms-nvidia:
	docker push $(LLMS_NVIDIA_IMAGE):$(VERSION)
	docker push $(LLMS_NVIDIA_IMAGE):latest

push-llms-cpu:
	docker push $(LLMS_CPU_IMAGE):$(VERSION)
	docker push $(LLMS_CPU_IMAGE):latest

push-llms-mac:
	docker push $(LLMS_MAC_IMAGE):$(VERSION)
	docker push $(LLMS_MAC_IMAGE):latest

push-llms: push-llms-nvidia push-llms-cpu push-llms-mac

push-datascience-nvidia:
	docker push $(DATASCIENCE_NVIDIA_IMAGE):$(VERSION)
	docker push $(DATASCIENCE_NVIDIA_IMAGE):latest

push-datascience-cpu:
	docker push $(DATASCIENCE_CPU_IMAGE):$(VERSION)
	docker push $(DATASCIENCE_CPU_IMAGE):latest

push-datascience-mac:
	docker push $(DATASCIENCE_MAC_IMAGE):$(VERSION)
	docker push $(DATASCIENCE_MAC_IMAGE):latest

push-datascience: push-datascience-nvidia push-datascience-cpu push-datascience-mac

push-kaggle-nvidia:
	docker push $(KAGGLE_NVIDIA_IMAGE):$(VERSION)
	docker push $(KAGGLE_NVIDIA_IMAGE):latest

push-kaggle-cpu:
	docker push $(KAGGLE_CPU_IMAGE):$(VERSION)
	docker push $(KAGGLE_CPU_IMAGE):latest

push-kaggle-mac:
	docker push $(KAGGLE_MAC_IMAGE):$(VERSION)
	docker push $(KAGGLE_MAC_IMAGE):latest

push-kaggle: push-kaggle-nvidia push-kaggle-cpu push-kaggle-mac

push-all: push-deeplearning push-llms push-datascience push-kaggle

# Build, push, and update readmes
all: build-all push-all update-readme-all

# ─── DockerHub README targets ──────────────────────────────────────────────────

define update_readme
	@if [ ! -f .env ]; then echo "Error: .env file not found"; exit 1; fi
	@. ./.env && TOKEN=$$(curl -s -H "Content-Type: application/json" -X POST \
		-d "{\"username\": \"$$DOCKERHUB_USERNAME\", \"password\": \"$$DOCKERHUB_TOKEN\"}" \
		https://hub.docker.com/v2/users/login/ | jq -r .token); \
	echo "Updating README for $(1)..."; \
	FULL_DESC=$$(jq -Rs . < ./$(1)/README.md); \
	curl -s -X PATCH "https://hub.docker.com/v2/repositories/gperdrizet/$(1)/" \
		-H "Authorization: JWT $$TOKEN" \
		-H "Content-Type: application/json" \
		-d "{\"full_description\": $$FULL_DESC}" > /dev/null && \
	echo "Successfully updated $(1) README"
endef

update-readme-deeplearning-nvidia:
	$(call update_readme,deeplearning-nvidia)

update-readme-deeplearning-cpu:
	$(call update_readme,deeplearning-cpu)

update-readme-llms-nvidia:
	$(call update_readme,llms-nvidia)

update-readme-llms-cpu:
	$(call update_readme,llms-cpu)

update-readme-datascience-nvidia:
	$(call update_readme,datascience-nvidia)

update-readme-datascience-cpu:
	$(call update_readme,datascience-cpu)

update-readme-datascience-mac:
	$(call update_readme,datascience-mac)

update-readme-deeplearning-mac:
	$(call update_readme,deeplearning-mac)

update-readme-llms-mac:
	$(call update_readme,llms-mac)

update-readme-kaggle-nvidia:
	$(call update_readme,kaggle-nvidia)

update-readme-kaggle-cpu:
	$(call update_readme,kaggle-cpu)

update-readme-kaggle-mac:
	$(call update_readme,kaggle-mac)

update-readme-all: \
	update-readme-deeplearning-nvidia update-readme-deeplearning-cpu update-readme-deeplearning-mac \
	update-readme-llms-nvidia update-readme-llms-cpu update-readme-llms-mac \
	update-readme-datascience-nvidia update-readme-datascience-cpu update-readme-datascience-mac \
	update-readme-kaggle-nvidia update-readme-kaggle-cpu update-readme-kaggle-mac

# ─── PyTorch wheel build ───────────────────────────────────────────────────────

PYTORCH_VERSION ?= 2.11.0
CUDA_ARCH_LIST  ?= 6.0;6.1;7.0;7.5;8.0;8.6;8.9;9.0;10.0
MAX_JOBS        ?= 16

# deeplearning-nvidia only — llms-nvidia uses the same wheel.
# Build takes 3-4 hours. Upload resulting wheel to GitHub Releases after building.
wheel-deeplearning-nvidia:
	@echo "Building PyTorch wheel for deeplearning-nvidia (Python 3.12, CUDA 12.8)..."
	@echo "This will take 3-4 hours. Grab some coffee."
	DOCKER_BUILDKIT=1 docker build \
		--network=host \
		--build-arg PYTORCH_VERSION=$(PYTORCH_VERSION) \
		--build-arg CUDA_ARCH_LIST="$(CUDA_ARCH_LIST)" \
		--build-arg MAX_JOBS=$(MAX_JOBS) \
		--shm-size=16g \
		-t pytorch-builder-deeplearning-nvidia:$(PYTORCH_VERSION) \
		-f ./deeplearning-nvidia/Dockerfile.build-pytorch \
		./deeplearning-nvidia

extract-wheel-deeplearning-nvidia:
	@echo "Extracting wheel from pytorch-builder-deeplearning-nvidia..."
	@mkdir -p ./wheels
	docker create --name wheel-extract-dl pytorch-builder-deeplearning-nvidia:$(PYTORCH_VERSION)
	docker cp wheel-extract-dl:/wheels/. ./wheels/
	docker rm wheel-extract-dl
	@echo "Wheel saved to ./wheels/"

# ─── CuPy wheel build ───────────────────────────────────────────────────────

# datascience-nvidia only — llms-nvidia uses the same wheel.
# Build takes about an hour. Upload resulting wheel to GitHub Releases after building.

CUPY_VERSION ?= 13.6.0

wheel-datascience-nvidia:
	@echo "Building CuPy wheel for datascience-nvidia (Python 3.12, CUDA 12.8)..."
	@echo "This will take about an hour. Grab some coffee."
	DOCKER_BUILDKIT=1 docker build \
		--network=host \
		--shm-size=16g \
		--build-arg CUPY_VERSION=$(CUPY_VERSION) \
		-t cupy-builder-datascience-nvidia:$(CUPY_VERSION) \
		-f ./datascience-nvidia/Dockerfile.build-cupy \
		./datascience-nvidia

extract-wheel-datascience-nvidia:
	@echo "Extracting wheel from cupy-builder-datascience-nvidia..."
	@mkdir -p ./wheels
	docker create --name wheel-extract-ds cupy-builder-datascience-nvidia:$(CUPY_VERSION)
	docker cp wheel-extract-ds:/wheels/. ./wheels/
	docker rm wheel-extract-ds
	@echo "Wheel saved to ./wheels/"