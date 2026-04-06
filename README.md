# JiraRC

#### Jira CLI inspired Zsh plugin that provides shortcuts for repetitive commands

## Requirements

- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [Jira CLI](https://github.com/ankitpokhrel/jira-cli)

## Installation

- Download the repository in your Oh My Zsh custom plugins folder (usually `~/.oh-my-zsh/custom/plugins/`)

```bash
git clone https://github.com/aoantov/jirarc.git ~/.oh-my-zsh/custom/plugins/jirarc
```

Or

```bash
git clone https://github.com/aoantov/jirarc.git ~/.oh-my-zsh/custom/plugins/jirarc && ln -s $(pwd)/jirarc ~/.oh-my-zsh/custom/plugins/jirarc
```

- Add `jirarc` to the plugins list in your `~/.zshrc` file

```bash
# Add Optionals here
plugins=(... jirarc)
```

## Optionals

##### Some commands are based on the column state. To rapidly move issues using some commands you have to define the following variables. All variables are optional

```
 export TO_DO_STATUS = '<To Do Column Name>'
 export BLOCKED_STATUS= '<Blocked Column Name>'
 export IN_PROGRESS_STATUS = '<In Progress Column Name>'
 export REVIEW_STATUS = '<Review Column Name>'
 export QA_STATUS = '<QA Column Name>'
 export QA_USER = '<QA User Account>'
 export DONE_STATUS = '<Done Column Name>'
```

## Commands

- jrua: Unassign an issue (assign to empty user)
- jre: Edit an issue
- jrrw: Move an issue to 'Review' status (REVIEW_STATUS needed)
- jram: Assign an issue to me
- jracs: Add issue to current sprint
- jrpr: Move an issue to 'In Progress' status and assign to me (IN_PROGRESS_STATUS needed)
- jrbk: Move an issue back to 'Blocked' status (BLOCKED_STATUS needed)
- jrtd: Move an issue to 'To Do' status and unassign (TO_DO_STATUS needed)
- jrav: List available issues in current sprint (TO_DO_STATUS needed)
- jriav: List available issues in current sprint (TO_DO_STATUS needed, interactive)
- jrdn: Move an issue to 'Done' status and unassign (DONE_STATUS needed)
- jrqa: Move an issue to 'QA' status and assign to QA user (QA_STATUS and QA_USER needed)
- jrme: List issues in the current sprint assigned to me
- jrel: List epics in the current sprint
- jriel: List epics in the current sprint (interactive)
- jrime: List issues in the current sprint assigned to me (interactive)
- jrall: List all issues assigned to me
- jriall: List all issues assigned to me (interactive)
- jrcat: View details of a specific issue
- jra: Assign an issue to a user
- jrd: Delete an issue
- jrmv: Move an issue to a different status
- jrrm: Remove (delete) an issue
- jric: Create a new issue
- jrls: List top 50 sprints
- jrils: List top 50 sprints (interactive)
- jrec: Create a new epic
- jreu: Unassign epic from an issue
- jrcm: Add a comment to an issue
- jrcs: List issues in the current sprint
- jrics: List issues in the current sprint (interactive)
- jrop: Open an issue in the web browser
- jrhelp: Show help for JiraRC commands
