#!/usr/bin/env bash

# shellcheck disable=SC1090

function setup() {
  local deno_env="$HOME/.deno/env"
  local deno_autocompletions="$HOME/.local/share/bash-completion/completions/deno.bash"
  [ -s "$deno_env" ] && \. "$deno_env"
  [ -s "$deno_autocompletions" ] && \. "$deno_autocompletions"
}

setup

unset setup
