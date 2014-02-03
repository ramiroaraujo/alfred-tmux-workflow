#!/usr/bin/env ruby
# encoding: utf-8

require_relative "bundle/bundler/setup"
require "alfred"

name = ARGV[0] || ''

Alfred.with_friendly_error do |alfred|

  fb = alfred.feedback


  # get list of tmux sessions
  sessions = `/usr/local/bin/tmux list-sessions -F "#S"`.split "\n"

  name = name[1..-1] if name.length > 0

  if name.length == 0
    # show default text indicating new session action
    fb.add_item({
                    :title => 'Write a new session name',
                    :subtitle => 'add a space after the tmux command and write your new session name',
                    :valid => 'no',
                })
  elsif !(ARGV[0] =~ /^ /)
    # show wrong syntax error
    fb.add_item({
                    :title => 'Invalid parameter',
                    :subtitle => 'Please leave a space after the tmux command',
                    :valid => 'no',
                })
  elsif (sessions + %w(default)).include? name
    # show duplicated session name error
    fb.add_item({
                    :title => 'Duplicated session name',
                    :subtitle => "the session #{name} already exists",
                    :valid => 'no',
                })
  else
    # show new session name action
    fb.add_item({
                    :title => "Create session \"#{name}\"",
                    :subtitle => "creates a new tmux session with a session name: #{name}",
                    :arg => "2|#{name}",
                    :valid => 'yes',
                })
  end

  # deletes session default
  sessions.delete_if { |s| s == 'default' }

  sessions = sessions.each_with_index.map do |name, i|
    {
        :name => name,
        :title => "connect to session #{name}",
        :arg => "#{i+4}|"
    }
  end

  # adds session default to front
  sessions.unshift({:name => 'default', :title => 'connect to default session', :arg => '1|'})

  # adds base terminal option
  sessions.unshift({:name => 'zsh', :title => 'launch zsh', :arg => '3|'})

  sessions.each do |session|
    fb.add_item({
                    :title => session[:title],
                    :arg => session[:arg],
                    :valid => 'yes',
                })

  end
  puts fb.to_xml()
end