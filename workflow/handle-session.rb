#!/usr/bin/env ruby
# encoding: utf-8

# extract variables
command, name, change_dir = ARGV[0].split '|'

# creates tmux session in home dir if needed
create = command == 'new'

# checks if iTerm is running
iterm_running = `/bin/ps aux | /usr/bin/grep iTerm | /usr/bin/wc -l | /usr/bin/tr -d ' ' | /usr/bin/tr -d '\n'`.to_i - 2

# run applescript with extracted/calculated params
`/usr/bin/osascript open_tmux_session.scpt "#{iterm_running}|#{name}|#{create}|#{change_dir}"`