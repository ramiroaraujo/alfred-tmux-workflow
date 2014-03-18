# Tmux Workflow for Alfred app

Alfred workflow to manage tmux sessions, integrated with iTerm2. It can list current sessions, connect to them, kill them or create a new one. The connect or create action actually opens iTerm2 and connects to the session. Additionally, in all the _open_ actions (new session or connect to session) it can ```cd``` to the current Finder's or Path Finder's directory.

Please note: the workflow _only_ handles tmux sessions. It doesn't handle windows, panes, or any other tmux command.

## Dependencies

* [iTerm2](http://www.iterm2.com/) installed
* [tmux](http://tmux.sourceforge.net/) installed in ```/usr/local/bin/tmux```; easily installed with [homebrew](http://brew.sh/) doing ```brew install tmux```

## Usage

Write the ```tmux``` keyword in Alfred to trigger the workflow.
![tmux main menu](https://raw.github.com/ramiroaraujo/alfred-tmux-workflow/master/screenshots/tmux-main-menu.png)

The initial menu options are:

1. An initial _not actionable_ menu item indicating to keep writing after the keyword to search/filter or create a new session.
2. Option to connect to a default tmux session. It's a session named "default" that will always appear in the menu, and if it doesn't exists it will be automatically created.

You can start typing right away after the keyword for search or create a session, or optionally add a space after the keyword for readability; the space is ignored. You'll see the filtered results (bash/zsh included), and a last option to created a new tmux session with the entered name, if non existent.

![tmux create session](https://raw.github.com/ramiroaraujo/alfred-tmux-workflow/master/screenshots/tmux-create-session.png)
![tmux search sessions](https://raw.github.com/ramiroaraujo/alfred-tmux-workflow/master/screenshots/tmux-search-sessions.png)

If you want to kill a session, action it with ```⌥``` down. If failure, for example trying to kill the bash/zsh option, you'll hear a classic error sound.

If you want to open the current Finder's or [Path Finder's](http://cocoatech.com/pathfinder/) folder, action the current or new session with ```⌘``` down. This command is very fast for new tmux sessions but adds a delay of 1 second for existent tmux sessions, since I cannot find a way to wait for tmux session to load, except by waiting long enough. Still, opening current Finder's path in already existing sessions shouldn't be that common.

## Installation
For OS X 10.9 Mavericks, Download the [alfred-tmux.alfredworkflow](https://github.com/ramiroaraujo/alfred-tmux-workflow/raw/master/alfred-tmux.alfredworkflow) and import to Alfred 2.

For Previous OS X Versions, Download the [alfred-tmux.alfredworkflow](https://github.com/ramiroaraujo/alfred-tmux-workflow/raw/pre-mavericks/alfred-tmux.alfredworkflow) and import to Alfred 2.

## Changelog
* _2014-02-05_ - Released
