#!/bin/bash
# CI Secret Guard - Lightweight leak prevention
# Scans files in the current directory for common secret patterns before deployment

echo "🔍 Starting CI Secret Guard scan..."

# Define common patterns for secrets (API keys, tokens, passwords)
PATTERNS=(
  "AKIA[0-9A-Z]{16}" # AWS Access Key
  "ghp_[0-9a-zA-Z]{36}" # GitHub Personal Access Token
  "xoxb-[0-9]{10,13}-[a-zA-Z0-9]{24}" # Slack Bot Token
  "sk_live_[0-9a-zA-Z]{24}" # Stripe Secret Key
  "password[[:space:]]*=|PASSWORD[[:space:]]*=" # Hardcoded passwords
)

FOUND_LEAK=0

# Scan all files excluding .git directory
for pattern in "${PATTERNS[@]}"; do
  if grep -rE "$pattern" . --exclude-dir=".git" > /dev/null 2>&1; then
    echo "❌ ALERT: Potential secret leaked matching pattern: $pattern"
    FOUND_LEAK=1
  fi
done

if [ $FOUND_LEAK -eq 1 ]; then
  echo "🛑 Build failed due to detected secrets. Please use environment variables."
  exit 1
else
  echo "✅ No hardcoded secrets detected. Safe to proceed."
  exit 0
fi



TODO: Add support for GitLab CI variables
