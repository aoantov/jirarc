
 function jr() {
   printf "  [1mRequired[0m
   ○ jira-cli 

  [1mOptional[0m
    [31mNote:[0m Place before loading of plugins
    ○ TO_DO_STATUS
    ○ BLOCKED_STATUS
    ○ IN_PROGRESS_STATUS
    ○ REVIEW_STATUS
    ○ QA_STATUS
    ○ QA_USER
    ○ DONE_STATUS

  [1mCommands[0m
    ○ jre: Edit an issue
    ○ jra: Assign an issue (default to me)
    ○ jru: Unassign an issue (assign to empty user)
    ○ jrtd: Move an issue to 'To Do' status and unassign (TO_DO_STATUS needed)
    ○ jrpr: Move an issue to 'In Progress' status and assign to me (IN_PROGRESS_STATUS needed)
    ○ jrbk: Move an issue back to 'Blocked' status (BLOCKED_STATUS needed)
    ○ jrrw: Move an issue to 'Review' status (REVIEW_STATUS needed)
    ○ jrqa: Move an issue to 'QA' status and assign to QA user (QA_STATUS and QA_USER needed)
    ○ jrdn: Move an issue to 'Done' status and unassign (DONE_STATUS needed)
    ○ jrlbk: Link issue as blocking another issue
    ○ jrldp: Link issue as duplicate of another issue
    ○ jrlcn: Link issue as clone of another issue
    ○ jrlco: Link issue as connected to another issue
    ○ jrlrt: Link issue relating to another issue
    ○ jrw: Add user to watchers of an issue (default to me)
    ○ jracs: Add issue to current sprint
    ○ jrav: List available issues in current sprint (TO_DO_STATUS needed)
    ○ jriav: List available issues in current sprint (TO_DO_STATUS needed, interactive)
    ○ jrc: Create a new issue
    ○ jrcat: View details of a specific issue
    ○ jrcn: Clone an issue
    ○ jrrm: Delete an issue
    ○ jrcm: Add a comment to an issue
    ○ jrop: Open an issue in the web browser
    ○ jrall: List all issues assigned to me
    ○ jriall: List all issues assigned to me (interactive)
    ○ jrmv: Move an issue to a different status
    ○ jrlk: Link issue to another issue
    ○ jrls: List top 50 sprints
    ○ jrils: List top 50 sprints (interactive)
    ○ jrcs: List issues in the current sprint
    ○ jrics: List issues in the current sprint (interactive)
    ○ jrme: List issues in the current sprint assigned to me
    ○ jrime: List issues in the current sprint assigned to me (interactive)
    ○ jrel: List epics 
    ○ jriel: List epics (interactive)
    ○ jrec: Create a new epic 
    ○ jrea: Assign issue to an epic
    ○ jreu: Unassign an issue from an epic
    ○ jrilr: List releases (interactive)
    ○ jrhelp: Show help for JiraRC commands
"
 }
