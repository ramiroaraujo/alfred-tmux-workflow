#!/usr/bin/env ruby
# encoding: utf-8

name = ARGV[0].split('|')[2]

sessions = `/usr/local/bin/tmux list-sessions -F "#S"`.split "\n"

unless sessions.include? name
  `/usr/bin/afplay /System/Library/Sounds/Funk.aiff`
  exit 1
end

`/usr/local/bin/tmux kill-session -t "#{name}"`

print name