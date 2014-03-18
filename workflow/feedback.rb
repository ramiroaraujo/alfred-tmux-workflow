#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'bundle/bundler/setup'
require 'alfred'

name = ARGV[0] || ''

Alfred.with_friendly_error do |alfred|

  fb = alfred.feedback

  # get list of tmux sessions
  sessions = `/usr/local/bin/tmux list-sessions -F "#S"`.split "\n"

  name = name[1..-1] if name =~ /^ /

  # deletes session default
  has_default = sessions.include? 'default'
  sessions.delete_if { |s| s == 'default' }

  # rewrite sessions has hashes with feedback and argument data
  sessions = sessions.map do |s|
    {
        :name => s,
        :title => "connect to session \"#{s}\"",
        :subtitle => "open iTerm and connect to tmux session \"#{s}\"",
        :arg => "attach|#{s}"
    }
  end

  # adds session default to front
  sessions.unshift({:name => 'default', :title => 'connect to default session', :subtitle => 'connects to tmux session named "default"', :arg => "#{has_default ? 'attach':'new'}|default"})


  if name.length == 0
    # show default text indicating new session action
    fb.add_item({
                    :title => 'Write a new session name or search an existing one',
                    :subtitle => 'add a space after the tmux command and write your new session name',
                    :valid => 'no',
                })
  else
    # filter sessions with search input
    sessions = sessions.select do |session|
      true if session[:name].downcase =~ /#{name}/
    end
  end

  # add each session data to Alfred's feedback
  sessions.each do |session|
    fb.add_item({
                    :title => session[:title],
                    :subtitle => session[:subtitle],
                    :arg => session[:arg],
                    :valid => 'yes',
                })
  end

  # if search input present, and search input is not exactly an existing session show create session
  if name.length > 0 && sessions.none? { |s| s[:name] == name }
    fb.add_item({
                    :title => "Create session \"#{name}\"",
                    :subtitle => "creates a new tmux session with a session name: #{name}",
                    :arg => "new|#{name}",
                    :valid => 'yes',
                })
  end

  puts fb.to_xml()
end