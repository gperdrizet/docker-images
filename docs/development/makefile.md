# Makefile Reference

These targets are useful for local development and testing. The CI/CD pipeline calls the same targets during a release.

## Build

| Command | Description |
|---------|-------------|
| `make build-datascience-nvidia` | Build datascience NVIDIA image |
| `make build-datascience-cpu` | Build datascience CPU image |
| `make build-datascience-mac` | Build datascience Mac (linux/arm64) image |
| `make build-datascience` | Build all three datascience images |
| `make build-deeplearning-nvidia` | Build deeplearning NVIDIA image |
| `make build-deeplearning-cpu` | Build deeplearning CPU image |
| `make build-deeplearning-mac` | Build deeplearning Mac (linux/arm64) image |
| `make build-deeplearning` | Build all three deeplearning images |
| `make build-llms-nvidia` | Build llms NVIDIA image |
| `make build-llms-cpu` | Build llms CPU image |
| `make build-llms-mac` | Build llms Mac (linux/arm64) image |
| `make build-llms` | Build all three llms images |
| `make build-kaggle-nvidia` | Build kaggle NVIDIA image |
| `make build-kaggle-cpu` | Build kaggle CPU image |
| `make build-kaggle-mac` | Build kaggle Mac (linux/arm64) image |
| `make build-kaggle` | Build all three kaggle images |
| `make build-all` | Build all twelve images |

## Test

| Command | Description |
|---------|-------------|
| `make test-datascience-nvidia` | Test datascience NVIDIA image |
| `make test-datascience-cpu` | Test datascience CPU image |
| `make test-datascience-mac` | Test datascience Mac image |
| `make test-deeplearning-nvidia` | Test deeplearning NVIDIA image |
| `make test-deeplearning-cpu` | Test deeplearning CPU image |
| `make test-deeplearning-mac` | Test deeplearning Mac image |
| `make test-llms-nvidia` | Test llms NVIDIA image |
| `make test-llms-cpu` | Test llms CPU image |
| `make test-llms-mac` | Test llms Mac image |
| `make test-kaggle-nvidia` | Test kaggle NVIDIA image |
| `make test-kaggle-cpu` | Test kaggle CPU image |
| `make test-kaggle-mac` | Test kaggle Mac image |
| `make test-nvidia` | Test all NVIDIA images |
| `make test-cpu` | Test all CPU images |
| `make test-mac` | Test all Mac images |
| `make test-all` | Test all twelve images |

Test scripts are in `tests/` and can be run directly with an optional image tag:

```bash
bash tests/test-deeplearning-cpu.sh gperdrizet/deeplearning-cpu:5.2.0
```

## Push

| Command | Description |
|---------|-------------|
| `make push-datascience-nvidia` | Push datascience NVIDIA image |
| `make push-datascience-cpu` | Push datascience CPU image |
| `make push-datascience-mac` | Push datascience Mac image |
| `make push-datascience` | Push all three datascience images |
| `make push-deeplearning-nvidia` | Push deeplearning NVIDIA image |
| `make push-deeplearning-cpu` | Push deeplearning CPU image |
| `make push-deeplearning-mac` | Push deeplearning Mac image |
| `make push-deeplearning` | Push all three deeplearning images |
| `make push-llms-nvidia` | Push llms NVIDIA image |
| `make push-llms-cpu` | Push llms CPU image |
| `make push-llms-mac` | Push llms Mac image |
| `make push-llms` | Push all three llms images |
| `make push-kaggle-nvidia` | Push kaggle NVIDIA image |
| `make push-kaggle-cpu` | Push kaggle CPU image |
| `make push-kaggle-mac` | Push kaggle Mac image |
| `make push-kaggle` | Push all three kaggle images |
| `make push-all` | Push all twelve images |

## DockerHub READMEs

Requires a `.env` file in the project root:

```bash
DOCKERHUB_USERNAME=gperdrizet
DOCKERHUB_TOKEN=your-dockerhub-pat
```

| Command | Description |
|---------|-------------|
| `make update-readme-datascience-nvidia` | Update datascience-nvidia DockerHub README |
| `make update-readme-datascience-cpu` | Update datascience-cpu DockerHub README |
| `make update-readme-datascience-mac` | Update datascience-mac DockerHub README |
| `make update-readme-deeplearning-nvidia` | Update deeplearning-nvidia DockerHub README |
| `make update-readme-deeplearning-cpu` | Update deeplearning-cpu DockerHub README |
| `make update-readme-deeplearning-mac` | Update deeplearning-mac DockerHub README |
| `make update-readme-llms-nvidia` | Update llms-nvidia DockerHub README |
| `make update-readme-llms-cpu` | Update llms-cpu DockerHub README |
| `make update-readme-llms-mac` | Update llms-mac DockerHub README |
| `make update-readme-kaggle-nvidia` | Update kaggle-nvidia DockerHub README |
| `make update-readme-kaggle-cpu` | Update kaggle-cpu DockerHub README |
| `make update-readme-kaggle-mac` | Update kaggle-mac DockerHub README |
| `make update-readme-all` | Update all DockerHub READMEs |
