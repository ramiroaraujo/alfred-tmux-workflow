#!/usr/bin/env ruby
# encoding: utf-8

require_relative "bundle/bundler/setup"
require "alfred"

name = ARGV[0] || ''

Alfred.with_friendly_error do |alfred|

  fb = alfred.feedback


  # get list of tmux sessions
  sessions = `/usr/local/bin/tmux list-sessions -F "#S"`.split "\n"

  name = name[1..-1] if name =~ /^ /

  # deletes session default
  sessions.delete_if { |s| s == 'default' }

  sessions = sessions.each_with_index.map do |name, i|
    {
        :name => name,
        :title => "connect to session \"#{name}\"",
        :subtitle => "open iTerm and connect to tmux session \"#{name}\"",
        :arg => "#{i+4}|#{name}"
    }
  end

  # adds session default to front
  sessions.unshift({:name => 'default', :title => 'connect to default session', :subtitle => 'connects to tmux session named "default"', :arg => '1|'})

  # adds base terminal option
  sessions.unshift({:name => 'zsh', :title => 'launch bash/zsh', :subtitle => 'launch plain-old bash or zsh, without tmux', :arg => '3|'})


  if name.length == 0
    # show default text indicating new session action
    fb.add_item({
                    :title => 'Write a new session name or search an existing one',
                    :subtitle => 'add a space after the tmux command and write your new session name',
                    :valid => 'no',
                })
  else
    sessions = sessions.select do |session|
      true if session[:name].downcase =~ /#{name}/
    end
  end

  if sessions.empty?
    fb.add_item({
                    :title => "Create session \"#{name}\"",
                    :subtitle => "creates a new tmux session with a session name: #{name}",
                    :arg => "2|#{name}",
                    :valid => 'yes',
                })
  end

  sessions.each do |session|
    fb.add_item({
                    :title => session[:title],
                    :subtitle => session[:subtitle],
                    :arg => session[:arg],
                    :valid => 'yes',
                })

  end
  puts fb.to_xml()
end