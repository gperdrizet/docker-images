.PHONY: build-deeplearning-gpu build-deeplearning-cpu build-tensorflow-gpu build-tensorflow-cpu \
        build-llms-gpu build-llms-cpu \
        build-deeplearning build-tensorflow build-llms build-all \
        push-deeplearning-gpu push-deeplearning-cpu push-tensorflow-gpu push-tensorflow-cpu \
        push-llms-gpu push-llms-cpu \
        push-deeplearning push-tensorflow push-llms push-all all \
        update-readme-deeplearning-gpu update-readme-deeplearning-cpu \
        update-readme-tensorflow-gpu update-readme-tensorflow-cpu \
        update-readme-llms-gpu update-readme-llms-cpu \
        update-readme-all \
        wheel-llms-gpu wheel-deeplearning-gpu \
        extract-wheel-llms-gpu extract-wheel-deeplearning-gpu

# Version - update this when releasing a new version
VERSION ?= 3.3.0

# DockerHub credentials (set via environment variables or .env file)
DOCKERHUB_USERNAME ?= gperdrizet
DOCKERHUB_TOKEN ?=

# Image names
DEEPLEARNING_GPU_IMAGE := gperdrizet/deeplearning-gpu
DEEPLEARNING_CPU_IMAGE := gperdrizet/deeplearning-cpu
TENSORFLOW_GPU_IMAGE := gperdrizet/tensorflow-gpu
TENSORFLOW_CPU_IMAGE := gperdrizet/tensorflow-cpu
LLMS_GPU_IMAGE := gperdrizet/llms-gpu
LLMS_CPU_IMAGE := gperdrizet/llms-cpu

# Build targets - deeplearning
build-deeplearning-gpu:
	DOCKER_BUILDKIT=1 docker build --build-arg IMAGE_VERSION=$(VERSION) --shm-size=16g -t $(DEEPLEARNING_GPU_IMAGE):$(VERSION) -t $(DEEPLEARNING_GPU_IMAGE):latest ./deeplearning-gpu

build-deeplearning-cpu:
	docker build --build-arg IMAGE_VERSION=$(VERSION) -t $(DEEPLEARNING_CPU_IMAGE):$(VERSION) -t $(DEEPLEARNING_CPU_IMAGE):latest ./deeplearning-cpu

build-deeplearning: build-deeplearning-gpu build-deeplearning-cpu

# Build targets - tensorflow
build-tensorflow-gpu:
	docker build -t $(TENSORFLOW_GPU_IMAGE):$(VERSION) -t $(TENSORFLOW_GPU_IMAGE):latest ./tensorflow-gpu

build-tensorflow-cpu:
	docker build -t $(TENSORFLOW_CPU_IMAGE):$(VERSION) -t $(TENSORFLOW_CPU_IMAGE):latest ./tensorflow-cpu

build-tensorflow: build-tensorflow-gpu build-tensorflow-cpu

# Build targets - llms
build-llms-gpu:
	DOCKER_BUILDKIT=1 docker build --build-arg IMAGE_VERSION=$(VERSION) --shm-size=16g -t $(LLMS_GPU_IMAGE):$(VERSION) -t $(LLMS_GPU_IMAGE):latest ./llms-gpu

build-llms-cpu:
	docker build --build-arg IMAGE_VERSION=$(VERSION) -t $(LLMS_CPU_IMAGE):$(VERSION) -t $(LLMS_CPU_IMAGE):latest ./llms-cpu

build-llms: build-llms-gpu build-llms-cpu

# Build all (tensorflow archived)
build-all: build-deeplearning build-llms

# Push targets - deeplearning
push-deeplearning-gpu:
	docker push $(DEEPLEARNING_GPU_IMAGE):$(VERSION)
	docker push $(DEEPLEARNING_GPU_IMAGE):latest

push-deeplearning-cpu:
	docker push $(DEEPLEARNING_CPU_IMAGE):$(VERSION)
	docker push $(DEEPLEARNING_CPU_IMAGE):latest

push-deeplearning: push-deeplearning-gpu push-deeplearning-cpu

# Push targets - tensorflow
push-tensorflow-gpu:
	docker push $(TENSORFLOW_GPU_IMAGE):$(VERSION)
	docker push $(TENSORFLOW_GPU_IMAGE):latest

push-tensorflow-cpu:
	docker push $(TENSORFLOW_CPU_IMAGE):$(VERSION)
	docker push $(TENSORFLOW_CPU_IMAGE):latest

push-tensorflow: push-tensorflow-gpu push-tensorflow-cpu

# Push targets - llms
push-llms-gpu:
	docker push $(LLMS_GPU_IMAGE):$(VERSION)
	docker push $(LLMS_GPU_IMAGE):latest

push-llms-cpu:
	docker push $(LLMS_CPU_IMAGE):$(VERSION)
	docker push $(LLMS_CPU_IMAGE):latest

push-llms: push-llms-gpu push-llms-cpu

# Push all (tensorflow archived)
push-all: push-deeplearning push-llms

# Build, push, and update readmes
all: build-all push-all update-readme-all

# Update DockerHub README descriptions
update-readme-deeplearning-gpu:
	@if [ ! -f .env ]; then echo "Error: .env file not found"; exit 1; fi
	@echo "Getting DockerHub auth token..."
	@. ./.env && TOKEN=$$(curl -s -H "Content-Type: application/json" -X POST -d "{\"username\": \"$$DOCKERHUB_USERNAME\", \"password\": \"$$DOCKERHUB_TOKEN\"}" https://hub.docker.com/v2/users/login/ | jq -r .token); \
	echo "Updating README for deeplearning-gpu..."; \
	FULL_DESC=$$(jq -Rs . < ./deeplearning-gpu/README.md); \
	curl -s -X PATCH "https://hub.docker.com/v2/repositories/gperdrizet/deeplearning-gpu/" \
		-H "Authorization: JWT $$TOKEN" \
		-H "Content-Type: application/json" \
		-d "{\"full_description\": $$FULL_DESC}" > /dev/null && \
	echo "Successfully updated deeplearning-gpu README"

update-readme-deeplearning-cpu:
	@if [ ! -f .env ]; then echo "Error: .env file not found"; exit 1; fi
	@echo "Getting DockerHub auth token..."
	@. ./.env && TOKEN=$$(curl -s -H "Content-Type: application/json" -X POST -d "{\"username\": \"$$DOCKERHUB_USERNAME\", \"password\": \"$$DOCKERHUB_TOKEN\"}" https://hub.docker.com/v2/users/login/ | jq -r .token); \
	echo "Updating README for deeplearning-cpu..."; \
	FULL_DESC=$$(jq -Rs . < ./deeplearning-cpu/README.md); \
	curl -s -X PATCH "https://hub.docker.com/v2/repositories/gperdrizet/deeplearning-cpu/" \
		-H "Authorization: JWT $$TOKEN" \
		-H "Content-Type: application/json" \
		-d "{\"full_description\": $$FULL_DESC}" > /dev/null && \
	echo "Successfully updated deeplearning-cpu README"

update-readme-tensorflow-gpu:
	@if [ ! -f .env ]; then echo "Error: .env file not found"; exit 1; fi
	@echo "Getting DockerHub auth token..."
	@. ./.env && TOKEN=$$(curl -s -H "Content-Type: application/json" -X POST -d "{\"username\": \"$$DOCKERHUB_USERNAME\", \"password\": \"$$DOCKERHUB_TOKEN\"}" https://hub.docker.com/v2/users/login/ | jq -r .token); \
	echo "Updating README for tensorflow-gpu..."; \
	FULL_DESC=$$(jq -Rs . < ./tensorflow-gpu/README.md); \
	curl -s -X PATCH "https://hub.docker.com/v2/repositories/gperdrizet/tensorflow-gpu/" \
		-H "Authorization: JWT $$TOKEN" \
		-H "Content-Type: application/json" \
		-d "{\"full_description\": $$FULL_DESC}" > /dev/null && \
	echo "Successfully updated tensorflow-gpu README"

update-readme-tensorflow-cpu:
	@if [ ! -f .env ]; then echo "Error: .env file not found"; exit 1; fi
	@echo "Getting DockerHub auth token..."
	@. ./.env && TOKEN=$$(curl -s -H "Content-Type: application/json" -X POST -d "{\"username\": \"$$DOCKERHUB_USERNAME\", \"password\": \"$$DOCKERHUB_TOKEN\"}" https://hub.docker.com/v2/users/login/ | jq -r .token); \
	echo "Updating README for tensorflow-cpu..."; \
	FULL_DESC=$$(jq -Rs . < ./tensorflow-cpu/README.md); \
	curl -s -X PATCH "https://hub.docker.com/v2/repositories/gperdrizet/tensorflow-cpu/" \
		-H "Authorization: JWT $$TOKEN" \
		-H "Content-Type: application/json" \
		-d "{\"full_description\": $$FULL_DESC}" > /dev/null && \
	echo "Successfully updated tensorflow-cpu README"

update-readme-llms-gpu:
	@if [ ! -f .env ]; then echo "Error: .env file not found"; exit 1; fi
	@echo "Getting DockerHub auth token..."
	@. ./.env && TOKEN=$$(curl -s -H "Content-Type: application/json" -X POST -d "{\"username\": \"$$DOCKERHUB_USERNAME\", \"password\": \"$$DOCKERHUB_TOKEN\"}" https://hub.docker.com/v2/users/login/ | jq -r .token); \
	echo "Updating README for llms-gpu..."; \
	FULL_DESC=$$(jq -Rs . < ./llms-gpu/README.md); \
	curl -s -X PATCH "https://hub.docker.com/v2/repositories/gperdrizet/llms-gpu/" \
		-H "Authorization: JWT $$TOKEN" \
		-H "Content-Type: application/json" \
		-d "{\"full_description\": $$FULL_DESC}" > /dev/null && \
	echo "Successfully updated llms-gpu README"

update-readme-llms-cpu:
	@if [ ! -f .env ]; then echo "Error: .env file not found"; exit 1; fi
	@echo "Getting DockerHub auth token..."
	@. ./.env && TOKEN=$$(curl -s -H "Content-Type: application/json" -X POST -d "{\"username\": \"$$DOCKERHUB_USERNAME\", \"password\": \"$$DOCKERHUB_TOKEN\"}" https://hub.docker.com/v2/users/login/ | jq -r .token); \
	echo "Updating README for llms-cpu..."; \
	FULL_DESC=$$(jq -Rs . < ./llms-cpu/README.md); \
	curl -s -X PATCH "https://hub.docker.com/v2/repositories/gperdrizet/llms-cpu/" \
		-H "Authorization: JWT $$TOKEN" \
		-H "Content-Type: application/json" \
		-d "{\"full_description\": $$FULL_DESC}" > /dev/null && \
	echo "Successfully updated llms-cpu README"

# tensorflow archived
update-readme-all: update-readme-deeplearning-gpu update-readme-deeplearning-cpu update-readme-llms-gpu update-readme-llms-cpu

# PyTorch wheel build configuration
PYTORCH_VERSION ?= 2.5.1
CUDA_ARCH_LIST ?= 6.0;6.1;7.0;7.5;8.0;8.6;8.9;9.0
MAX_JOBS ?= 16

# PyTorch wheel build targets
# These build PyTorch from source with wide GPU architecture support (Pascal through Hopper)
# Build takes 3-4 hours. Wheels should be uploaded to GitHub Releases after building.

wheel-llms-gpu:
	@echo "Building PyTorch wheel for llms-gpu (Python 3.11, CUDA 12.6)..."
	@echo "This will take 3-4 hours. Grab some coffee."
	DOCKER_BUILDKIT=1 docker build \
		--build-arg PYTORCH_VERSION=$(PYTORCH_VERSION) \
		--build-arg CUDA_ARCH_LIST="$(CUDA_ARCH_LIST)" \
		--build-arg MAX_JOBS=$(MAX_JOBS) \
		--shm-size=16g \
		-t pytorch-builder-llms-gpu:$(PYTORCH_VERSION) \
		-f ./llms-gpu/Dockerfile.build-pytorch \
		./llms-gpu

wheel-deeplearning-gpu:
	@echo "Building PyTorch wheel for deeplearning-gpu (Python 3.10, CUDA 12.4)..."
	@echo "This will take 3-4 hours. Grab some coffee."
	DOCKER_BUILDKIT=1 docker build \
		--build-arg PYTORCH_VERSION=$(PYTORCH_VERSION) \
		--build-arg CUDA_ARCH_LIST="$(CUDA_ARCH_LIST)" \
		--build-arg MAX_JOBS=$(MAX_JOBS) \
		--shm-size=16g \
		-t pytorch-builder-deeplearning-gpu:$(PYTORCH_VERSION) \
		-f ./deeplearning-gpu/Dockerfile.build-pytorch \
		./deeplearning-gpu

# Extract wheels from builder containers
extract-wheel-llms-gpu:
	@echo "Extracting wheel from pytorch-builder-llms-gpu..."
	@mkdir -p ./wheels
	docker create --name wheel-extract-llms pytorch-builder-llms-gpu:$(PYTORCH_VERSION)
	docker cp wheel-extract-llms:/wheels/. ./wheels/
	docker rm wheel-extract-llms
	@echo "Wheel saved to ./wheels/"

extract-wheel-deeplearning-gpu:
	@echo "Extracting wheel from pytorch-builder-deeplearning-gpu..."
	@mkdir -p ./wheels
	docker create --name wheel-extract-dl pytorch-builder-deeplearning-gpu:$(PYTORCH_VERSION)
	docker cp wheel-extract-dl:/wheels/. ./wheels/
	docker rm wheel-extract-dl
	@echo "Wheel saved to ./wheels/"
