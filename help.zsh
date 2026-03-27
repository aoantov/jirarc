
 function jr() {
   printf "  [1mRequired[0m
   ○ jira-cli 

  [1mOptional[0m
    [31mNote:[0m Place before loading of plugins
    ○ IN_PROGRESS_STATUS
    ○ DONE_STATUS
    ○ BLOCKED_STATUS
    ○ TO_DO_STATUS
    ○ REVIEW_STATUS
    ○ QA_STATUS
    ○ QA_USER

  [1mCommands[0m
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
"
 }
