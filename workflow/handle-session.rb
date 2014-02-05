#!/usr/bin/env ruby
# encoding: utf-8

# extract variables
command, name, change_dir = ARGV[0].split '|'

# creates tmux session in home dir if needed
create = command == 'new'

# handle session creation here, specially if a change dir is necessary
if create
  dir = change_dir == '1' ? `/usr/bin/osascript get_finders_path.scpt`.chomp : '$HOME'
  `cd "#{dir}" && /usr/local/bin/tmux new-session -d -s "#{name}"`

  # override change dir since the new session is already there
  change_dir = '0'
end

# checks if iTerm is running
iterm_running = `/bin/ps aux | /usr/bin/grep iTerm | /usr/bin/wc -l | /usr/bin/tr -d ' ' | /usr/bin/tr -d '\n'`.to_i - 2

# run applescript with extracted/calculated params
`/usr/bin/osascript open_tmux_session.scpt "#{iterm_running}|#{name}|#{change_dir}"`