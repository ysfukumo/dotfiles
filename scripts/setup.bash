#!/usr/bin/env bash

set -eux
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

/bin/bash "$BASE_DIR/setup-apt.bash"
/bin/bash "$BASE_DIR/setup-homebrew.bash"
/bin/bash "$BASE_DIR/setup-links.bash"
/bin/bash "$BASE_DIR/setup-mac.bash"
/bin/bash "$BASE_DIR/setup-deno.bash"
/bin/bash "$BASE_DIR/setup-zinit.bash"

