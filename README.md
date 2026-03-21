# JiraRC

#### Jira CLI inspired Zsh plugin that provides shortcuts for repetitive commands

## Requirements

- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [Jira CLI](https://github.com/ankitpokhrel/jira-cli)

## Installation

- Download the repository in your Oh My Zsh custom plugins folder (usually `~/.oh-my-zsh/custom/plugins/`)

```bash
cd ~/.oh-my-zsh/custom/plugins/ && git clone https://github.com/aoantov/jirarc.git
```

Or

```bash
git clone https://github.com/aoantov/jirarc.git && ln -s $(pwd)/jirarc ~/.oh-my-zsh/custom/plugins/jirarc
```

- Add `jirarc` to the plugins list in your `~/.zshrc` file

```bash
# Add Optionals here
plugins=(... jirarc)
```

## Optionals

##### Some commands are based on the column state. To rapidly move issues using some commands you have to define the following variables. All variables are optional

```
 export IN_PROGRESS_STATUS = '<In Progress Column Name>'
 export DONE_STATUS = '<Done Column Name>'
 export TO_DO_STATUS = '<To Do Column Name>'
 export REVIEW_STATUS = '<Review Column Name>'
 export QA_STATUS = '<QA Column Name>'
 export QA_USER = '<QA User Account>'
```

## Commands

- jrme: List issues in the current sprint assigned to me
- jrime: List issues in the current sprint assigned to me (interactive)
- jrall: List all issues assigned to me
- jriall: List all issues assigned to me (interactive)
- jrcat: \<issue-key\>: View details of a specific issue
- jra: \<issue-key\>: Assign an issue to a user
- jrmv: \<issue-key\>: Move an issue to a different status
- jrrm: \<issue-key\>: Remove (delete) an issue
- jric: Create a new issue
- jrcm: \<issue-key\> \<comment\>: Add a comment to an issue
- jrcs: List issues in the current sprint
- jrics: List issues in the current sprint (interactive)
- jrop: \<issue-key\>: Open an issue in the web browser
- jrua: \<issue-key\>: Unassign an issue (assign to empty user)
- jram: \<issue-key\>: Assign an issue to me
- jrrw: \<issue-key\>: Move an issue to 'Review' status
- jrbk: \<issue-key\>: Move an issue back to 'Blocked' status
- jrtd: \<issue-key\>: Move an issue to 'To Do' status and unassign
- jrpr: \<issue-key\>: Move an issue to 'In Progress' status and assign to me
- jrdn: \<issue-key\>: Move an issue to 'Done'
- jrqa: Move an issue to 'QA' status and assign to QA user
- jr/jrhelp: Show help for JiraRC commands
