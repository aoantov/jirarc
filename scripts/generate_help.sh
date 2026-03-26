#!/bin/zsh

local script_file="${1:-jirarc.plugin.zsh}"

local help_functions=$(
  awk '
  /^# @desc:/ {
    desc = substr($0, 10)       # extract the description
    getline                       # read next line (should be function)
    if ($0 ~ /^function[[:space:]]+[a-zA-Z0-9_]+/) {
      fn = $0
      sub(/^function[[:space:]]+/, "", fn)   # remove "function " prefix
      sub(/\(.*/, "", fn)                     # remove everything after (
      print "    - " fn ": " desc
    }
  }
' $script_file
)

local help_aliases=$(
  awk '
  /^# @desc:/ {
    desc = substr($0, 10)       # extract the description
    getline                       # read next line (should be alias)
    if ($0 ~ /^alias[[:space:]]+[a-zA-Z0-9_]+/) {
      fn = $0
      sub(/^alias[[:space:]]+/, "", fn)   # remove "alias " prefix
      sub(/=.*/, "", fn)
      print "    - " fn ": " desc
    }
  }
' $script_file
)

cat <<EOF
  Requirements:
   - jira-cli 

  Optional:
    (Place before loading of plugins)
    - IN_PROGRESS_STATUS
    - DONE_STATUS
    - BLOCKED_STATUS
    - TO_DO_STATUS
    - REVIEW_STATUS
    - QA_STATUS
    - QA_USER

  Commands:
$help_functions
$help_aliases
EOF
