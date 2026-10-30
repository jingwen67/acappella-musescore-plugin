#!/bin/bash
# Background updates never discard local edits and wait while MuseScore is open.
set -eu
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
repo_root="$(cd -- "$(dirname -- "$0")/.." && pwd -P)"
if /usr/bin/pgrep -ix 'MuseScore.*|mscore.*' >/dev/null 2>&1; then exit 0; fi
if [ "$(git -C "$repo_root" branch --show-current)" != main ]; then exit 0; fi
if [ -n "$(git -C "$repo_root" status --porcelain)" ]; then exit 0; fi
repo_origin="$(git -C "$repo_root" remote get-url origin)"
case "$repo_origin" in
  https://github.com/jingwen67/acappella-musescore-plugin.git|https://github.com/jingwen67/acappella-musescore-plugin|git@github.com:jingwen67/acappella-musescore-plugin.git) ;;
  *) exit 0 ;;
esac
export GIT_TERMINAL_PROMPT=0
export GIT_SSH_COMMAND='ssh -oBatchMode=yes -oConnectTimeout=15'
git -C "$repo_root" -c http.connectTimeout=15 -c http.lowSpeedLimit=1 -c http.lowSpeedTime=30 fetch --quiet origin main
# Recheck after network activity in case MuseScore was opened or files edited.
if /usr/bin/pgrep -ix 'MuseScore.*|mscore.*' >/dev/null 2>&1; then exit 0; fi
if [ "$(git -C "$repo_root" branch --show-current)" != main ]; then exit 0; fi
if [ -n "$(git -C "$repo_root" status --porcelain)" ]; then exit 0; fi
git -C "$repo_root" merge --ff-only --quiet refs/remotes/origin/main
