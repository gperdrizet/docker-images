# Releasing a Version

1. Make changes, commit, and push to `main` as normal.
2. When ready to release, go to **GitHub Actions → CI → Run workflow**, enter the version number (e.g. `5.2.0`), and click **Run workflow**.

The pipeline runs automatically:

1. **Build** — all twelve images are built in parallel with the specified version tag (linux/arm64 via QEMU).
2. **Test** — CPU, NVIDIA, and Mac image tests run in parallel.
3. **Approve** — the pipeline pauses; a notification is sent for manual approval.
4. **Push** — on approval, images are pushed to DockerHub and DockerHub READMEs are updated.
5. **Tag** — a git tag (`vx.x.x`) and GitHub release are created automatically.
6. **Sync** — a dispatch event is sent to `datascience-devcontainer`, `deeplearning-devcontainer`, `llms-devcontainer`, and `kaggle-devcontainer`, which each create a matching version tag and GitHub release.

!!! note
    Git tags are only created after a successful, approved push — a tag always corresponds to a verified image on DockerHub.
