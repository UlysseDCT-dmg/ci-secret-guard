# ci-secret-guard
A lightweight CI utility to prevent environment variables and API keys from leaking into build logs.
# 🛡️ CI Secret Guard

A lightweight, no-dependency CI/CD utility designed to silently prevent environment variables, API keys, and sensitive tokens from leaking into build logs or being accidentally committed.

## Why this exists
In fast-moving teams, it is incredibly common for a developer to temporarily hardcode an API key for testing and forget to remove it before pushing to the repository. While large-scale SAST tools exist, they are often too heavy or expensive for small internal pipelines. `CI Secret Guard` fills this gap as a quiet, instant-execution safety net.

## How it works
This script runs in your CI environment (GitHub Actions, GitLab CI, Jenkins) right before the build/deploy step. It uses regex pattern matching to detect exposed credentials (AWS keys, GitHub tokens, Slack Webhooks, etc.) and immediately fails the build with an exit code 1 if a leak is detected, preventing the deployment of sensitive data.

## Usage
Add this to your deployment pipeline script:

```bash
chmod +x scan_secrets.sh
./scan_secrets.sh
