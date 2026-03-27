empty_user="x"

in_progress_status=$IN_PROGRESS_STATUS
to_do_status=$TO_DO_STATUS
blocked_status=$BLOCKED_STATUS
review_status=$REVIEW_STATUS
done_status=$DONE_STATUS
qa_status=$QA_STATUS
qa_user=$QA_USER

# @desc: Unassign an issue (assign to empty user)
function jrua() {
  if [ -z "$1" ]; then
    echo "Usage: jrua <issue-key>"
    return 1
  fi

  jira issue assign "$1" "$empty_user"
}

# @desc: Edit an issue
function jre() {
  if [ -z "$1" ]; then
    echo "Usage: jre <issue-key>"
    return 1
  fi

  jira issue edit "$1"
}

# @desc: Move an issue to 'Review' status (REVIEW_STATUS needed)
function jrrw() {
  if [ -z "$1" ]; then
    echo "Usage: jrrw <issue-key>"
    return 1
  fi

  jira issue move "$1" "$review_status"
}

# @desc: Assign an issue to me
function jram() {
  if [ -z "$1" ]; then
    echo "Usage: jram <issue-key>"
    return 1
  fi

  jira issue assign "$1" $(jira me)
}

# @desc: Add issue to current sprint
function jracs() {
  if [ -z "$1" ]; then
    echo "Usage: jracs <issue-key>"
    return 1
  fi

  local current_sprint_id = $(jira sprint list --state active --columns id --no-header | sed -n 's2p')
  jira sprint add $current_sprint_id "$1"
}

# @desc: Move an issue to 'To Do' status and unassign (TO_DO_STATUS needed)
function jrtd() {
  if [ -z "$1" ]; then
    echo "Usage: jrtd <issue-key>"
    return 1
  fi

  jira issue move "$1" "$to_do_status" && jira issue assign "$1" $(jira me)
}

# @desc: Move an issue to 'In Progress' status and assign to me (IN_PROGRESS_STATUS needed)
function jrpr() {
  jira issue move "$1" "$in_progress_status" && jira issue assign "$1" $(jira me)
}

# @desc: Move an issue back to 'Blocked' status (BLOCKED_STATUS needed)
function jrbk() {
  jira issue move "$1" "$blocked_status"
}

# @desc: List available issues in current sprint (TO_DO_STATUS needed)
function jrav() {
  jira sprint list -a "$empty_user" -s "$to_do_status" --current --plain
}

# @desc: List available issues in current sprint (TO_DO_STATUS needed, interactive)
function jriav() {
  jira sprint list -a "$empty_user" -s "$to_do_status" --current
}

# @desc: Move an issue to 'Done' status and unassign (DONE_STATUS needed)
function jrdn() {
  if [ -z "$1" ]; then
    echo "Usage: jrdn <issue-key>"
    return 1
  fi

  jira issue move "$1" "$done_status" && jira issue assign "$1" "$empty_user"
}

# @desc: Move an issue to 'QA' status and assign to QA user (QA_STATUS and QA_USER needed)
function jrqa() {
  if [ -z "$1" ]; then
    echo "Usage: jrdn <issue-key>"
    return 1
  fi

  jira issue move "$1" "$qa_status" && jira issue assign "$1" "$qa_user"
}

function jr() {
  cat <<EOF 
  Requirements:
   ○ jira-cli

  Optional:
    (Place before loading of plugins)
    ○ IN_PROGRESS_STATUS
    ○ DONE_STATUS
    ○ BLOCKED_STATUS
    ○ TO_DO_STATUS
    ○ REVIEW_STATUS
    ○ QA_STATUS
    ○ QA_USER

  Commands:
    ○ jrua: Unassign an issue (assign to empty user)
    ○ jre: Edit an issue
    ○ jrrw: Move an issue to 'Review' status (REVIEW_STATUS needed)
    ○ jram: Assign an issue to me
    ○ jracs: Add issue to current sprint
    ○ jrtd: Move an issue to 'To Do' status and unassign (TO_DO_STATUS needed)
    ○ jrpr: Move an issue to 'In Progress' status and assign to me (IN_PROGRESS_STATUS needed)
    ○ jrbk: Move an issue back to 'Blocked' status (BLOCKED_STATUS needed)
    ○ jrav: List available issues in current sprint (TO_DO_STATUS needed)
    ○ jriav: List available issues in current sprint (TO_DO_STATUS needed, interactive)
    ○ jrdn: Move an issue to 'Done' status and unassign (DONE_STATUS needed)
    ○ jrqa: Move an issue to 'QA' status and assign to QA user (QA_STATUS and QA_USER needed)
    ○ jrme: List issues in the current sprint assigned to me
    ○ jrel: List epics in the current sprint
    ○ jriel: List epics in the current sprint (interactive)
    ○ jrime: List issues in the current sprint assigned to me (interactive)
    ○ jrall: List all issues assigned to me
    ○ jriall: List all issues assigned to me (interactive)
    ○ jrcat: View details of a specific issue
    ○ jra: Assign an issue to a user
    ○ jrd: Delete an issue
    ○ jrmv: Move an issue to a different status
    ○ jrrm: Remove (delete) an issue
    ○ jric: Create a new issue
    ○ jrls: List top 50 sprints
    ○ jrils: List top 50 sprints (interactive)
    ○ jrec: Create a new epic
    ○ jreu: Unassign epic from an issue
    ○ jrcm: Add a comment to an issue
    ○ jrcs: List issues in the current sprint
    ○ jrics: List issues in the current sprint (interactive)
    ○ jrop: Open an issue in the web browser
    ○ jrhelp: Show help for JiraRC commands
EOF
}

# Aliases for jira commands

# @desc: List issues in the current sprint assigned to me
alias jrme='jira sprint list --current --plain -a $(jira me)'

# @desc: List epics in the current sprint
alias jrel='jira epic list --table --plain'

# @desc: List epics in the current sprint (interactive)
alias jriel='jira epic list'

# @desc: List issues in the current sprint assigned to me (interactive)
alias jrime='jira sprint list --current -a $(jira me)'

# @desc: List all issues assigned to me
alias jrall='jira issues list --plain -a $(jira me)'

# @desc: List all issues assigned to me (interactive)
alias jriall='jira issues list -a $(jira me)'

# @desc: View details of a specific issue
alias jrcat='jira issue view'

# @desc: Assign an issue to a user
alias jra='jira issue assign'

# @desc: Delete an issue
alias jrd='jira issue delete'

# @desc: Move an issue to a different status
alias jrmv='jira issues move'

# @desc: Remove (delete) an issue
alias jrrm="jira issues delete"

# @desc: Create a new issue
alias jric='jira issues create'

# @desc: List top 50 sprints
alias jrls='jira sprint list --table --plain'

# @desc: List top 50 sprints (interactive)
alias jrils='jira sprint list'

# @desc: Create a new epic 
alias jrec='jira epic add'

# @desc: Unassign epic from an issue
alias jreu='jira epic remove'

# @desc: Add a comment to an issue
alias jrcm='jira issue comment add'

# @desc: List issues in the current sprint
alias jrcs='jira sprint list --current --plain'

# @desc: List issues in the current sprint (interactive)
alias jrics='jira sprint list --current'

# @desc: Open an issue in the web browser
alias jrop='jira open'

# @desc: Show help for JiraRC commands
alias jrhelp='jr'


# Unset functions if corresponding status IDs are not set
if [ -z $done_status ]
then
  unset -f jrdn
fi

if [ -z $in_progress_status ]
then
  unset -f jrpr
fi

if [ -z $to_do_status ]
then
  unset -f jrtd
  unset -f jrav 
  unset -f jriav 
fi

if [ -z $review_status ]
then
  unset -f jrrw
fi

if [ -z $qa_status ] || [ -z $qa_user ]
then
  unset -f jrqa
fi

if [ -z $blocked_status ]
then
  unset -f jrbk
fi
