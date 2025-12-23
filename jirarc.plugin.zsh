empty_user="x"

in_progress_status=$IN_PROGRESS_STATUS
to_do_status=$TO_DO_STATUS
review_status=$REVIEW_STATUS
done_status=$DONE_STATUS
qa_status=$QA_STATUS
qa_user=$QA_USER

# Custom methods
function jrua() {
  if [ -z "$1" ]; then
    echo "Usage: jrua <issue-key>"
    return 1
  fi

  jira issue assign "$1" "$empty_user"
}

function jrrw() {
  if [ -z "$1" ]; then
    echo "Usage: jrrw <issue-key>"
    return 1
  fi

  jira issue move "$1" "$review_status"
}


function jram() {
  if [ -z "$1" ]; then
    echo "Usage: jram <issue-key>"
    return 1
  fi

  jira issue assign "$1" $(jira me)
}

function jrtd() {
  if [ -z "$1" ]; then
    echo "Usage: jrtd <issue-key>"
    return 1
  fi

  jira issue move "$1" "$to_do_status" && jira issue assign "$1" "$empty_user"
}

function jrpr() {
  jira issue move "$1" "$in_progress_status" && jira issue assign "$1" $(jira me)
}



function jrdn() {
  if [ -z "$1" ]; then
    echo "Usage: jrdn <issue-key>"
    return 1
  fi

  jira issue move "$1" "$done_status" && jira issue assign "$1" $(jira me)
}

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
  - jira-cli should be installed and configured 

  Optional:
    (Place before loading of plugins)
    - IN_PROGRESS_STATUS +
    - DONE_STATUS -
    - TO_DO_STATUS *
    - REVIEW_STATUS ^
    - QA_STATUS v
    - QA_USER v


  Commands:
  - jrme: List issues in the current sprint assigned to me
  - jrime: List issues in the current sprint assigned to me (with details)
  - jrall: List all issues assigned to me
  - jrcat <issue-key>: View details of a specific issue
  - jra <issue-key>: Assign an issue to a user
  - jrmv <issue-key>: Move an issue to a different status
  - jrrm <issue-key>: Remove (delete) an issue
  - jric: Create a new issue
  - jrcm <issue-key> <comment>: Add a comment to an issue
  - jrcs: List issues in the current sprint
  - jrop <issue-key>: Open an issue in the web browser
  - jrua <issue-key>: Unassign an issue (assign to empty user)
  - jram <issue-key>: Assign an issue to me
  - jrrw(^) <issue-key>: Move an issue to 'Review' status
  - jrtd(*) <issue-key>: Move an issue to 'To Do' status and unassign
  - jrpr(+) <issue-key>: Move an issue to 'In Progress' status and assign to me
  - jrdn(-) <issue-key>: Move an issue to 'Done'
  - jrqa(v): Move an issue to 'QA' status and assign to QA user
EOF
}

# Aliases for jira commands
alias jrme='jira sprint list --current --plain -a $(jira me)'
alias jrime='jira sprint list --current -a $(jira me)'
alias jrall='jira issues list -a $(jira me)'
alias jrcat='jira issue view'
alias jra='jira issue assign'
alias jrmv='jira issues move'
alias jrrm="jira issues delete"
alias jric='jira issues create'
alias jrcm='jira issue comment add'
alias jrcs='jira sprint list --current'
alias jrop='jira open'

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
fi

if [ -z $review_status ]
then
  unset -f jrrw
fi

if [ -z $qa_status ] || [ -z $qa_user ]
then
  unset -f jrqa
fi

