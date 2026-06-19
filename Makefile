.PHONY: \
        build-deeplearning-nvidia build-deeplearning-cpu \
        build-llms-nvidia build-llms-cpu \
        build-datascience-nvidia build-datascience-cpu build-datascience-mac \
        build-deeplearning build-llms build-datascience build-all \
        push-deeplearning-nvidia push-deeplearning-cpu \
        push-llms-nvidia push-llms-cpu \
        push-datascience-nvidia push-datascience-cpu push-datascience-mac \
        push-deeplearning push-llms push-datascience push-all all \
        test-deeplearning-cpu test-deeplearning-nvidia \
        test-llms-cpu test-llms-nvidia \
        test-datascience-cpu test-datascience-nvidia test-datascience-mac \
        test-cpu test-nvidia test-mac test-all \
        update-readme-deeplearning-nvidia update-readme-deeplearning-cpu \
        update-readme-llms-nvidia update-readme-llms-cpu \
        update-readme-datascience-nvidia update-readme-datascience-cpu update-readme-datascience-mac \
        update-readme-all \
        wheel-deeplearning-nvidia \
        extract-wheel-deeplearning-nvidia

# Version - for local builds, defaults to the most recent git tag (e.g. v4.1.0 -> 4.1.0).
# CI passes VERSION explicitly via workflow_dispatch input; tags are created by CI after a
# successful push, so the tag always reflects a verified release.
# Override locally with: make build-all VERSION=4.1.0
VERSION ?= $(shell git describe --tags --abbrev=0 2>/dev/null | sed 's/^v//' | grep . || echo dev)

# DockerHub credentials (set via environment variables or .env file)
DOCKERHUB_USERNAME ?= gperdrizet
DOCKERHUB_TOKEN ?=

# Image names
DEEPLEARNING_NVIDIA_IMAGE := gperdrizet/deeplearning-nvidia
DEEPLEARNING_CPU_IMAGE    := gperdrizet/deeplearning-cpu
LLMS_NVIDIA_IMAGE         := gperdrizet/llms-nvidia
LLMS_CPU_IMAGE            := gperdrizet/llms-cpu
DATASCIENCE_NVIDIA_IMAGE  := gperdrizet/datascience-nvidia
DATASCIENCE_CPU_IMAGE     := gperdrizet/datascience-cpu
DATASCIENCE_MAC_IMAGE     := gperdrizet/datascience-mac

# ─── Build targets ────────────────────────────────────────────────────────────

# deeplearning
build-deeplearning-nvidia:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) --shm-size=16g \
		-t $(DEEPLEARNING_NVIDIA_IMAGE):$(VERSION) -t $(DEEPLEARNING_NVIDIA_IMAGE):latest ./deeplearning-nvidia

build-deeplearning-cpu:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		-t $(DEEPLEARNING_CPU_IMAGE):$(VERSION) -t $(DEEPLEARNING_CPU_IMAGE):latest ./deeplearning-cpu

build-deeplearning: build-deeplearning-nvidia build-deeplearning-cpu

# llms
build-llms-nvidia:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) --shm-size=16g \
		-t $(LLMS_NVIDIA_IMAGE):$(VERSION) -t $(LLMS_NVIDIA_IMAGE):latest ./llms-nvidia

build-llms-cpu:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		-t $(LLMS_CPU_IMAGE):$(VERSION) -t $(LLMS_CPU_IMAGE):latest ./llms-cpu

build-llms: build-llms-nvidia build-llms-cpu

# datascience
build-datascience-nvidia:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		-t $(DATASCIENCE_NVIDIA_IMAGE):$(VERSION) -t $(DATASCIENCE_NVIDIA_IMAGE):latest ./datascience-nvidia

build-datascience-cpu:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		-t $(DATASCIENCE_CPU_IMAGE):$(VERSION) -t $(DATASCIENCE_CPU_IMAGE):latest ./datascience-cpu

build-datascience-mac:
	DOCKER_BUILDKIT=1 docker buildx build --platform linux/arm64 --network=host --build-arg IMAGE_VERSION=$(VERSION) \
		--cache-from type=registry,ref=$(DATASCIENCE_MAC_IMAGE):latest \
		--cache-to type=inline \
		--load -t $(DATASCIENCE_MAC_IMAGE):$(VERSION) -t $(DATASCIENCE_MAC_IMAGE):latest ./datascience-mac

build-datascience: build-datascience-nvidia build-datascience-cpu build-datascience-mac

build-all: build-deeplearning build-llms build-datascience

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

test-cpu:    test-deeplearning-cpu test-llms-cpu test-datascience-cpu
test-nvidia: test-deeplearning-nvidia test-llms-nvidia test-datascience-nvidia
test-mac:    test-datascience-mac
test-all:    test-cpu test-nvidia test-mac

# ─── Push targets ─────────────────────────────────────────────────────────────

push-deeplearning-nvidia:
	docker push $(DEEPLEARNING_NVIDIA_IMAGE):$(VERSION)
	docker push $(DEEPLEARNING_NVIDIA_IMAGE):latest

push-deeplearning-cpu:
	docker push $(DEEPLEARNING_CPU_IMAGE):$(VERSION)
	docker push $(DEEPLEARNING_CPU_IMAGE):latest

push-deeplearning: push-deeplearning-nvidia push-deeplearning-cpu

push-llms-nvidia:
	docker push $(LLMS_NVIDIA_IMAGE):$(VERSION)
	docker push $(LLMS_NVIDIA_IMAGE):latest

push-llms-cpu:
	docker push $(LLMS_CPU_IMAGE):$(VERSION)
	docker push $(LLMS_CPU_IMAGE):latest

push-llms: push-llms-nvidia push-llms-cpu

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

push-all: push-deeplearning push-llms push-datascience

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

update-readme-all: \
	update-readme-deeplearning-nvidia update-readme-deeplearning-cpu \
	update-readme-llms-nvidia update-readme-llms-cpu \
	update-readme-datascience-nvidia update-readme-datascience-cpu update-readme-datascience-mac

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
