#!/bin/sh

# ignore validation files like shas

# Supports 4 arguments
#  1: gh repo owner
#  2: gh repo name
#  3: asset name as described in the gh release, if not set, will print available found
#  4: (optional) final name for installation
gh_install_latest_release() {
  local -r os="linux" arch="amd64"
  local -r owner=${1:?"repo owner must be set"}
  local -r repo=${2:?"repo name must be set"}

  local -r assets=$(curl -sL \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/$owner/$repo/releases/latest")

  if [ "$#" -le 2 ]; then
    echo "Release TAG: $(echo -E "$assets" | jq -r '.tag_name')"
    echo "Files found:"
    echo -E "$assets" | jq -r '.assets[] | "\(.name)  \(.browser_download_url)"' | grep -v "sha" | grep "$os"
  else
    local -r asset_name=${3:?"asset name must be set"}
    local -r download_url=$(echo -E "$assets" | jq -r ".assets[] | select(.name == \"$asset_name\") | .browser_download_url")
    local -r temp_dir=$(mktemp -d)
    curl -sL "$download_url" -O --output-dir "$temp_dir"
    if [ "$#" -eq 4 ]; then
      install_to_path "$temp_dir/$asset_name" "$4"
    else
      install_to_path "$temp_dir/$asset_name"
    fi
  fi
}
