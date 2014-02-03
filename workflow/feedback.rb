#!/usr/bin/env ruby
# encoding: utf-8

require_relative "bundle/bundler/setup"
require "alfred"


Alfred.with_friendly_error do |alfred|

  fb = alfred.feedback

  name = ARGV[0]

  # get list of tmux sessions
  sessions = `tmux list-sessions -F "#S"`.split "\n"

  # clones sessions for name validation
  session_names = sessions.clone

  # if there's a query, try to create a new tmux session with the query as a name
  if name
    # validate it start's with a space
    unless name =~ /^ /
      fb.add_item({
                      :uid => '',
                      :title => 'Invalid parameter',
                      :subtitle => 'Please leave a space after the tmux command',
                      :arg => '',
                      :valid => 'no',
                  })
      puts fb.to_xml()
      exit
    end
    # remove the space
    name = name[1..-1]
    if session_names.include? name
      fb.add_item({
                      :uid => '',
                      :title => 'Duplicated session name',
                      :subtitle => "the session #{name} already exists",
                      :arg => '',
                      :valid => 'no',
                  })
      puts fb.to_xml()
      exit
    end

    # show option to create new tmux session
    fb.add_item({
                    :uid => "",
                    :title => "Create session \"#{name}\"",
                    :subtitle => "feedback item",
                    :arg => "A test feedback Item",
                    :valid => "yes",
                })

  else

  end

  # deletes session default
  sessions.delete_if { |s| s == 'default' }

  sessions = sessions.each_with_index.map do |name, i|
    {
        :name => name,
        :title => "connect to Session #{name}",
        :arg => "#{i+4}|"
    }
  end

  # adds session default to front
  sessions.unshift({:name => 'default', :title => 'connect to Session default', :arg => 1})

  # adds base terminal option
  sessions.unshift({:name => 'zsh', :title => 'launch zsh', :arg => 3})

  sessions.each_with_index do |session, index|

  end
  # add an arbitrary feedback
  fb.add_item({
                  :uid => "",
                  :title => "Just a Test",
                  :subtitle => "feedback item",
                  :arg => "A test feedback Item",
                  :valid => "yes",
              })

  puts fb.to_xml()
end