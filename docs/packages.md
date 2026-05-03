# GitHub Package

This repository publishes a lightweight container image for the static EU AI Act Toolkit Pages site.

## Package

**Name:** `ghcr.io/artemhobotun/eu-ai-act-toolkit-site`

**Contents:** The static GitHub Pages site (`docs/`) served via nginx:alpine.

**Published to:** [GitHub Container Registry (GHCR)](https://github.com/artemhobotun/EU-AI-Act-Toolkit/pkgs/container/eu-ai-act-toolkit-site)

## Run locally

```bash
docker run --rm -p 8080:80 ghcr.io/artemhobotun/eu-ai-act-toolkit-site:latest
```

Then open: **http://localhost:8080**

## Tags

| Tag | Description |
|-----|-------------|
| `latest` | Most recent build from `main` |
| `<git-sha>` | Immutable build tied to a specific commit |

## When the image is published

The container is rebuilt automatically on every push to `main` that changes `docker/Dockerfile` or any file under `docs/`. It can also be triggered manually via the GitHub Actions workflow dispatch.

## Disclaimer

The container is a static documentation and site preview only. It is not a hosted compliance system, a live service, or a production deployment. The EU AI Act Toolkit is educational and informational — not legal advice.
