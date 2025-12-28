#!/bin/bash

# ============================================================================
# Build and copy web client to BFF
# ============================================================================
# This script builds the React web client and copies it to the BFF's wwwroot.
# The BFF serves the web client as static files, mimicking the production setup locally.
#
# Usage: run ./build-and-copy-web-client-to-bff.sh in the bash terminal
# Prerequisites: Node.js (minimum v22.16.0) and pnpm must be installed
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🔨 Building the web client..."
cd "$REPO_ROOT/src/clients/web" || exit 1
pnpm run build || exit 1

echo "🧹 Cleaning wwwroot..."
rm -rf "$REPO_ROOT/src/services/BFFs/BFF.Web/wwwroot"/*

echo "📦 Copying web client build to wwwroot..."
mkdir -p "$REPO_ROOT/src/services/BFFs/BFF.Web/wwwroot"
cp -r dist/* "$REPO_ROOT/src/services/BFFs/BFF.Web/wwwroot/" || exit 1

echo "✅ Done! The web client build is ready in wwwroot/"