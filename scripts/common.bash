#!/usr/bin/env bash
set -x

BASE_DIR="$(cd "$(dirname "$0")" || exit 1; pwd)"
REPO_DIR="$(cd "$(dirname "$0")/.." || exit 1; pwd)"
export BASE_DIR REPO_DIR

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

