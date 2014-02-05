# Tmux Workflow for Alfred app

Alfred workflow to manage tmux sessions, integrated with iTerm2. It can list current sessions, connect to them, kill them
or create a new one. The connect or create action actually opens iTerm2 and connects to the session. It can also open
a default bash or zsh shell. Additionally, in all the _open_ actions (new session, connect to session, or bash/zsh shell)
it can ```cd``` to the current Finder's or Path Finder's directory.

## Dependencies

* [iTerm2](http://www.iterm2.com/) installed
* [tmux](http://tmux.sourceforge.net/) installed in ```/usr/local/bin/tmux```; easily installed with [homebrew](http://brew.sh/) doing ```brew install tmux```

## Usage


## Installation


## Changelog

Alfred workflow to open current Finder or Path Finder path in iTerm2, in a Tmux session. The workflow is pretty much molded
to my needs, with a quite opinionated way of handling tmux. Still, I've found there's no default nor preferred way of
handling iTerm + tmux, say for example the embeded tmux integration in iTerm is quite unconfortable for my taste.

The workflow was initially meant to handle the actual opening of iTerm, connect to a tmux session and then cd to the
current path, but it may come to your needs to cd in an existing session, or a new one, or simply in bash or zsh.