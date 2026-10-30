#!/bin/bash
set -eu
if [ "$(uname -s)" != Darwin ]; then exit 1; fi
agent_label='com.jingwen.acappella-plugin.autoupdate'
launchctl bootout "gui/$(id -u)/$agent_label" >/dev/null 2>&1 || true
rm -f "$HOME/Library/LaunchAgents/$agent_label.plist"
echo '已关闭后台自动更新。插件和本地文件保留。'
