#!/bin/bash

# ============================================================================
# CommitLogFrontend Build & Deploy Script
# ============================================================================
# This script builds the React frontend and copies it to the BFF's wwwroot.
# The BFF serves the frontend as static files, mimicking the production setup locally.
#
# Usage: cd into CommitLogBFF root folder and run ./scripts/build-and-deploy-commit-log-frontend.sh
# Prerequisites: Node.js and pnpm must be installed
# ============================================================================

echo "🔨 Building the CommitLogFrontend React app..."
cd ../CommitLogFrontend
pnpm run build

echo "🧹 Cleaning wwwroot..."
rm -rf ../CommitLogBFF/wwwroot/*

echo "📦 Copying build to wwwroot..."
cp -r dist/* ../CommitLogBFF/wwwroot/

echo "✅ Done! The CommitLogReactFrontend build is ready in wwwroot/"
echo "▶️  Start BFF with: dotnet run"