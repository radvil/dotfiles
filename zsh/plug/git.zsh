#!/usr/bin/env zsh

# Git version checking
autoload -Uz is-at-least
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"

# The git prompt's git commands are read-only and should not interfere with
# other processes. This environment variable is equivalent to running with `git
# --no-optional-locks`, but falls back gracefully for older versions of git.
# See git(1) for and git-status(1) for a description of that flag.
#
# We wrap in a local function instead of exporting the variable directly in
# order to avoid interfering with manually-run git commands by the user.
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git-current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# Gets the number of commits ahead from remote
function git-commits_ahead() {
  if __git_prompt_git rev-parse --git-dir &>/dev/null; then
    echo "$(__git_prompt_git rev-list --count @{upstream}..HEAD 2>/dev/null)"
  fi
}

# Gets the number of commits behind remote
function git-commits_behind() {
  if __git_prompt_git rev-parse --git-dir &>/dev/null; then
    echo "$(__git_prompt_git rev-list --count HEAD..@{upstream} 2>/dev/null)"
  fi
}

# Outputs the name of the current user
function git-current_user_name() {
  __git_prompt_git config user.name 2>/dev/null
}

# Outputs the email of the current user
function git-current_user_email() {
  __git_prompt_git config user.email 2>/dev/null
}

# Output the name of the root directory of the git repository
function git-repo_name() {
  local repo_path
  if repo_path="$(__git_prompt_git rev-parse --show-toplevel 2>/dev/null)" && [[ -n "$repo_path" ]]; then
    echo ${repo_path:t}
  fi
}

## @ref https://stackoverflow.com/questions/10312521/how-do-i-fetch-all-git-branches
function git-sync_all_brances() {
	git branch -r | grep -v '\->' | sed "s,\x1b\[[0-9;]*[a-za-z],,g" | while read -r remote; do git branch --track "${remote#origin/}" "$remote"; done
	git fetch --all
	git pull --all
}

function git-rename_branch() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi
  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

# Similar to `gunwip` but recursive "Unwips" all recent `--wip--` commits not just the last one
function git-unwip_all() {
  local _commit=$(git log --grep='--wip--' --invert-grep --max-count=1 --format=format:%H)
  # Check if a commit without "--wip--" was found and it's not the same as HEAD
  if [[ "$_commit" != "$(git rev-parse HEAD)" ]]; then
    git reset $_commit || return 1
  fi
}

alias git-wip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'

# Warn if the current branch is a WIP
function git-wip_current_branch() {
  command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--" && echo "WIP!!"
}

function git-delete_all_branches() {
  git branch --no-color --merged | command grep -ve "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch --delete 2>/dev/null
}

# copied and modified from james roeder (jmaroeder) under mit license
# https://github.com/jmaroeder/plugin-git/blob/216723ef4f9e8dde399661c39c80bdf73f4076c4/functions/gbda.fish
function git-delete_selected_branches() {
  local default_branch=$(git_main_branch)
  (( ! $? )) || default_branch=$(git_develop_branch)
  git for-each-ref refs/heads/ "--format=%(refname:short)" | \
    while read branch; do
      local merge_base=$(git merge-base $default_branch $branch)
      if [[ $(git cherry $default_branch $(git commit-tree $(git rev-parse $branch\^{tree}) -p $merge_base -m _)) = -* ]]; then
        git branch -d $branch
      fi
    done
}

# --jobs=<n> was added in git 2.8
is-at-least 2.8 "$git_version" \
  && alias git-fetch_all='git fetch --all --prune --jobs=10' \
  || alias git-fetch_all='git fetch --all --prune'

alias git-pull_rebase='git pull --rebase -v'

alias git-push_force!='git push --force'
is-at-least 2.30 "$git_version" \
  && alias git-push_force='git push --force-with-lease --force-if-includes' \
  || alias git-push_force='git push --force-with-lease'

alias git-push_upstream='git push --set-upstream origin $(git-current_branch)'
is-at-least 2.30 "$git_version" \
  && alias git-push_upstream='git push --set-upstream origin $(git-current_branch) --force-with-lease --force-if-includes' \
  || alias git-push_upstream='git push --set-upstream origin $(git-current_branch) --force-with-lease'

