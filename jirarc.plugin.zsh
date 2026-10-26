local PLUGIN_DIR="${0:A:h}"
source "$PLUGIN_DIR/help.generated.zsh"

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

empty_user="x"
in_progress_status=$IN_PROGRESS_STATUS
to_do_status=$TO_DO_STATUS
blocked_status=$BLOCKED_STATUS
review_status=$REVIEW_STATUS
done_status=$DONE_STATUS
qa_status=$QA_STATUS
qa_user=$QA_USER

# -----------------------------------------------------------------------------
# Issues: create, view, edit, delete
# -----------------------------------------------------------------------------

# @desc: Create a new issue
alias jrc='jira issues create'

# @desc: View details of a specific issue
alias jrcat='jira issue view'

# @desc: Edit an issue
function jre() {
  if [ -z "$1" ]; then
    echo "Usage: jre <issue-key>"
    return 1
  fi

  jira issue edit "$1"
}

# @desc: Clone an issue
alias jrcn='jira issue clone'

# @desc: Delete an issue
alias jrrm="jira issues delete"

# @desc: Add a comment to an issue
alias jrcm='jira issue comment add'

# @desc: Open an issue in the web browser
alias jrop='jira open'

# -----------------------------------------------------------------------------
# Issues: listing
# -----------------------------------------------------------------------------

# @desc: List all issues assigned to me
alias jrall='jira issues list --plain -a $(jira me)'

# @desc: List all issues assigned to me (interactive)
alias jriall='jira issues list -a $(jira me)'

# -----------------------------------------------------------------------------
# Assignment
# -----------------------------------------------------------------------------


# @desc: Assign an issue (default to me)
function jra() {
  if [ -z "$1" ]; then
    echo "Usage: jra <issue-key>"
    return 1
  fi

  jira issue assign "$1" "${2:-$(jira me)}"
}

# @desc: Unassign an issue (assign to empty user)
function jru() {
  if [ -z "$1" ]; then
    echo "Usage: jru <issue-key>"
    return 1
  fi

  jira issue assign "$1" "$empty_user"
}

# -----------------------------------------------------------------------------
# Status transitions
# -----------------------------------------------------------------------------

# @desc: Move an issue to a different status
alias jrmv='jira issues move'

if [ -n "$to_do_status" ]; then
  # @desc: Move an issue to 'To Do' status and unassign (TO_DO_STATUS needed)
  function jrtd() {
    if [ -z "$1" ]; then
      echo "Usage: jrtd <issue-key>"
      return 1
    fi
  
    jira issue move "$1" "$to_do_status" && jira issue assign "$1" $(jira me)
  }
fi

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

# -----------------------------------------------------------------------------
# Links
# -----------------------------------------------------------------------------

# @desc: Link issue to another issue
alias jrlk='jira issue link'

# @desc: Link issue as blocking another issue
function jrlbk() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: jrlbk <blocked-key> <blocking-key>"
    return 1
  fi

  jira issue link "$1" "$2" "Blocks"
}

# @desc: Link issue as duplicate of another issue
function jrldp() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: jrldp <original-key> <duplicate-key>"
    return 1
  fi

  jira issue link "$1" "$2" "Duplicate"
}

# @desc: Link issue as clone of another issue
function jrlcn() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: jrlcn <original-key> <clone-key>"
    return 1
  fi

  jira issue link "$1" "$2" "Cloners"
}

# @desc: Link issue as connected to another issue
function jrlco() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: jrlco <from-key> <to-key>"
    return 1
  fi

  jira issue link "$1" "$2" "Discovery-Connected"
}

# @desc: Link issue relating to another issue
function jrlrt() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: jrlrt <first-key> relates to <second-key>"
    return 1
  fi

  jira issue link "$1" "$2" "Relates"
}

# -----------------------------------------------------------------------------
# Watchers
# -----------------------------------------------------------------------------


# @desc: Add user to watchers of an issue (default to me)
function jrw() {
  if [ -z "$1" ]; then
    echo "Usage: jrw <issue-key>"
    return 1
  fi

  jira issue watch "$1" "${2:-$(jira me)}"
}

# -----------------------------------------------------------------------------
# Sprints
# -----------------------------------------------------------------------------

# @desc: Add issue to current sprint
function jracs() {
  if [ -z "$1" ]; then
    echo "Usage: jracs <issue-key>"
    return 1
  fi

  local current_sprint_id=$(jira sprint list --state active --table --plain --no-headers | awk '{print $1}')
  jira sprint add "$current_sprint_id" "$1"
}

# @desc: List top 50 sprints
alias jrls='jira sprint list --table --plain'

# @desc: List top 50 sprints (interactive)
alias jrils='jira sprint list'

# @desc: List issues in the current sprint
alias jrcs='jira sprint list --current --plain'

# @desc: List issues in the current sprint (interactive)
alias jrics='jira sprint list --current'

# @desc: List issues in the current sprint assigned to me
alias jrme='jira sprint list --current --plain -a $(jira me)'

# @desc: List issues in the current sprint assigned to me (interactive)
alias jrime='jira sprint list --current -a $(jira me)'

if [ -n "$to_do_status" ]; then
  # @desc: List available issues in current sprint (TO_DO_STATUS needed)
  function jrav() {
    jira sprint list -a "$empty_user" -s "$to_do_status" --current --plain
  }

  # @desc: List available issues in current sprint (TO_DO_STATUS needed, interactive)
  function jriav() {
    jira sprint list -a "$empty_user" -s "$to_do_status" --current
  }
fi

# -----------------------------------------------------------------------------
# Epics
# -----------------------------------------------------------------------------

# @desc: List epics 
alias jrel='jira epic list --plain --table'

# @desc: List epics (interactive)
alias jriel='jira epic list'

# @desc: Create a new epic 
alias jrec='jira epic create'

# @desc: Assign issue to an epic
alias jrea='jira epic add'

# @desc: Unassign an issue from an epic
alias jreu='jira epic remove'

# -----------------------------------------------------------------------------
# Releases
# -----------------------------------------------------------------------------

# @desc: List releases (interactive)
alias jrilr='jira releases list'

# -----------------------------------------------------------------------------
# Help
# -----------------------------------------------------------------------------

# @desc: Show help for JiraRC commands
alias jrhelp='jr'
