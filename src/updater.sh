#!/bin/bash

set -eo pipefail

echo "[INFO] Install npm-check-updates"

sudo npm i -g npm-check-updates

cd $GITHUB_WORKSPACE

echo "[INFO] Setting git config."

REMOTE="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git config user.name "DependenciesUpdater"
git config user.email "InkoHX@users.noreply.github.com"
git remote set-url origin $REMOTE

echo "Check for updates."

sudo ncu -u --packageFile package.json

if [[ `git status --porcelain` ]]; then
  echo "Update found!"
  echo "Updating lock file..."
  sudo npm install

  echo "Commit and Push"
  sudo git add .
  sudo git commit -m "Updated all dependencies"
  sudo git push origin HEAD:master
fi