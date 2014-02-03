#!/usr/bin/env ruby
# encoding: utf-8

name = ARGV[0].split('|')[1]

sessions = `/usr/local/bin/tmux list-sessions -F "#S"`.split "\n"

exit 1 unless sessions.include? name

`/usr/local/bin/tmux kill-session -t "#{name}"`

print name