#!/bin/env bash
# shellcheck source=/dev/null
source "$HOME/.radvil/_utils.sh"
source "$HOME/.radvil/aliases"
branch_name="$1"
dot push -d origin "$branch_name"
dot branch -D "$branch_name"
[ ! $? -eq 0 ] && warn "failed to remove branch $branch_name" || echo "✔ branch $branch_name removed"
