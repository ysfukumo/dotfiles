#!/bin/sh

INSTALL_DIR="${INSTALL_DIR:-$HOME/repos/github.com/ysfukumo/dotfiles}"

if [ -d "${INSTALL_DIR}" ]; then
  echo "Update dotfiles..."
  git -C "${INSTALL_DIR}" pull
else
  echo "Install dotfiles..."
  git clone https://github.com/ysfukumo/dotfiles "${INSTALL_DIR}"
fi

/bin/bash "${INSTALL_DIR}/scripts/setup.bash"

