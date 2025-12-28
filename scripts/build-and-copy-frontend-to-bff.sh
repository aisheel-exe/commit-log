#!/bin/bash

# ============================================================================
# Build and copy frontend to BFF
# ============================================================================
# This script builds the React frontend and copies it to the BFF's wwwroot.
# The BFF serves the frontend as static files, mimicking the production setup locally.
#
# Usage: run ./build-and-copy-frontend-to-bff in the bash terminal
# Prerequisites: Node.js (minimum v22.16.0) and pnpm must be installed
# ============================================================================

# Get the absolute path to the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Navigate to the repository root (one level up from scripts/)
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🔨 Building the frontend..."
cd "$REPO_ROOT/apps/frontend" || exit 1
pnpm run build || exit 1

echo "🧹 Cleaning wwwroot..."
rm -rf "$REPO_ROOT/apps/bff/src/wwwroot"/*

echo "📦 Copying frontend build to wwwroot..."
mkdir -p "$REPO_ROOT/apps/bff/src/wwwroot"
cp -r dist/* "$REPO_ROOT/apps/bff/src/wwwroot/" || exit 1

echo "✅ Done! The frontend build is ready in wwwroot/"
echo "▶️  Start BFF with: dotnet run"