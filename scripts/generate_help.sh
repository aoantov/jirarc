#!/bin/zsh

local script_file="${1:-jirarc.plugin.zsh}"
local bold="\\e[1m"
local base_color="\\e[0m"
local red_color="\\e[31m"
local spacing_header="  "

local help_functions=$(
  awk '
  /# @desc:/ {
    desc = $0
    sub(/[ ]*# @desc:[ ]*/, "", desc)  # remove "# @desc: " prefix
    getline                       # read next line (should be function)
    if ($0 ~ /function[[:space:]]+[a-zA-Z0-9_]+/) {
      fn = $0
      sub(/[ ]*function[[:space:]]+/, "", fn)   # remove "function " prefix
      sub(/\(.*/, "", fn)                     # remove everything after (
      print "    ○ " fn ": " desc
    }
  }
' $script_file
)

local help_aliases=$(
  awk '
  /# @desc:/ {
    desc = $0
    sub(/[ ]*# @desc:[ ]*/, "", desc)  # remove "# @desc: " prefix
    getline                       # read next line (should be alias)
    if ($0 ~ /[ ]*alias[[:space:]]+[a-zA-Z0-9_]+/) {
      fn = $0
      sub(/[ ]*alias[[:space:]]+/, "", fn)   # remove "alias " prefix
      sub(/=.*/, "", fn)
      print "    ○ " fn ": " desc
    }
  }
' $script_file
)

local help_info="${spacing_header}${bold}Required${base_color}
   ○ jira-cli 

${spacing_header}${bold}Optional${base_color}
    ${red_color}Note:${base_color} Place before loading of plugins
    ○ TO_DO_STATUS
    ○ BLOCKED_STATUS
    ○ IN_PROGRESS_STATUS
    ○ REVIEW_STATUS
    ○ QA_STATUS
    ○ QA_USER
    ○ DONE_STATUS

${spacing_header}${bold}Commands${base_color}
$help_functions
$help_aliases
"

printf "
 function jr() {
   printf \"$help_info\"
 }
"
