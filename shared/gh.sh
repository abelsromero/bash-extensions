#!/bin/sh

# ignore validation files like shas

# Downloads and installs a GH binary from a gh release (compressed files not supported yet).
#  1: gh repo owner
#  2: gh repo name
#  3: asset name as described in the gh release, if not set, will print available found
#  4: (optional) final name for installation
gh_install_latest_release() {
  local -r os="linux" arch="amd64"
  local -r owner=${1:?"repo owner must be set"}
  local -r repo=${2:?"repo name must be set"}
  local -r assets=$(__get_latest_release "$owner/$repo")

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

# Downloads a GH release file in the current directory.
#  1: gh repo owner
#  2: gh repo name
#  3: asset name as described in the gh release, if not set, will print available found
#  4: (optional) final name for installation
gh_download_latest_release() {
  local -r os="linux" arch="amd64"
  local -r owner=${1:?"repo owner must be set"}
  local -r repo=${2:?"repo name must be set"}
  local -r asset_name=${3:?"asset name must be set"}

  local -r assets=$(__get_latest_release "$owner/$repo")
  local -r download_url=$(echo -E "$assets" | jq -r ".assets[] | select(.name == \"$asset_name\") | .browser_download_url")
  curl -sL "$download_url" -O --output-dir "."
}

__get_latest_release() {
  curl -sL \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      "https://api.github.com/repos/$1/releases/latest"
}

__get_artifacts () {
  echo -E "$(__get_latest_release "$1/$2")" | jq -r '.assets[].name' | grep -v "sha"
}

_gh_install_latest_release_completion() {
  local -r current_word="${COMP_WORDS[COMP_CWORD]}"

  local options
  if [ "$COMP_CWORD" -eq 1 ]; then
    options="repo_owner"
  elif [ "$COMP_CWORD" -eq 2 ]; then
    options="repo_name"
  elif [ "$COMP_CWORD" -eq 3 ]; then
    options=$(__get_artifacts "${COMP_WORDS[1]}" "${COMP_WORDS[2]}")
  fi
  COMPREPLY=($(compgen -W "$options" -- "$current_word"))
}

complete -F _gh_install_latest_release_completion gh_install_latest_release
complete -F _gh_install_latest_release_completion gh_download_latest_release
