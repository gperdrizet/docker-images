# CI/CD infrastructure

## GitHub Actions secrets

Set in **GitHub repo Settings → Secrets → Actions**:

| Secret | Used for |
|--------|----------|
| `DOCKERHUB_USERNAME` | DockerHub login |
| `DOCKERHUB_TOKEN` | DockerHub PAT (Read, Write & Delete) |
| `GH_DISPATCH_TOKEN` | GitHub fine-grained PAT to push tags to this repo and trigger devcontainer repo syncs. Requires Contents: read/write on `docker-images`, `datascience-devcontainer`, `deeplearning-devcontainer`, `llms-devcontainer`, and `kaggle-devcontainer`. |

## Self-hosted runner

The runner is installed as a systemd service on the GPU host:

```bash
sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status
```

It polls GitHub via long-polling HTTPS; no inbound ports are required. Jobs are rejected unless `github.repository_owner == 'gperdrizet'`.
