local PLUGIN_DIR="${0:A:h}"
source "$PLUGIN_DIR/help.generated.zsh"

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

if [ -n "$review_status" ]; then
  # @desc: Move an issue to 'Review' status (REVIEW_STATUS needed)
  function jrrw() {
    if [ -z "$1" ]; then
      echo "Usage: jrrw <issue-key>"
      return 1
    fi
  
    jira issue move "$1" "$review_status"
  }
fi

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

  local current_sprint_id=$(jira sprint list --state active --table --plain --no-headers | awk '{print $1}')
  jira sprint add "$current_sprint_id" "$1"
}


if [ -n "$in_progress_status" ]; then
  # @desc: Move an issue to 'In Progress' status and assign to me (IN_PROGRESS_STATUS needed)
  function jrpr() {
    jira issue move "$1" "$in_progress_status" && jira issue assign "$1" $(jira me)
  }
fi

if [ -n "$blocked_status" ]; then
  # @desc: Move an issue back to 'Blocked' status (BLOCKED_STATUS needed)
  function jrbk() {
    jira issue move "$1" "$blocked_status"
  }
fi

if [ -n "$to_do_status" ]; then
  # @desc: Move an issue to 'To Do' status and unassign (TO_DO_STATUS needed)
  function jrtd() {
    if [ -z "$1" ]; then
      echo "Usage: jrtd <issue-key>"
      return 1
    fi
  
    jira issue move "$1" "$to_do_status" && jira issue assign "$1" $(jira me)
  }

  # @desc: List available issues in current sprint (TO_DO_STATUS needed)
  function jrav() {
    jira sprint list -a "$empty_user" -s "$to_do_status" --current --plain
  }

  # @desc: List available issues in current sprint (TO_DO_STATUS needed, interactive)
  function jriav() {
    jira sprint list -a "$empty_user" -s "$to_do_status" --current
  }
fi

if [ -n "$done_status" ]; then
  # @desc: Move an issue to 'Done' status and unassign (DONE_STATUS needed)
  function jrdn() {
    if [ -z "$1" ]; then
      echo "Usage: jrdn <issue-key>"
      return 1
    fi
  
    jira issue move "$1" "$done_status" && jira issue assign "$1" "$empty_user"
  }
fi

if [ -n "$qa_status" ] && [ -n "$qa_user" ]; then
  # @desc: Move an issue to 'QA' status and assign to QA user (QA_STATUS and QA_USER needed)
  function jrqa() {
    if [ -z "$1" ]; then
      echo "Usage: jrqa <issue-key>"
      return 1
    fi
  
    jira issue move "$1" "$qa_status" && jira issue assign "$1" "$qa_user"
  }
fi


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
