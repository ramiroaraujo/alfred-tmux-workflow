on run command
	set options to my split(command as string, "|")
	set iterm_running to (item 1 of options) as integer
	set session_name to item 2 of options
	set change_dir to (item 3 of options) as integer


	tell application "iTerm"
		activate
		set termCount to count of terminals
		
		if termCount is 0 then
			set _term to (make new terminal)
		else
			if iterm_running > 0 then
				set _term to the first terminal
				tell i term application "System Events" to keystroke "t" using command down
			end if
		end if
		
		try
			set _session to current session of current terminal
		on error
			tell _term
				launch session "Default"
				set _session to current session
			end tell
		end try
		
		tell _session
		    if session_name is not "" then
                write text "tmux attach -d -t \"" & session_name & "\""
		    end if
			if change_dir > 0 then
				delay 1
                set target_path to do shell script "/usr/bin/osascript get_finders_path.scpt"
                set change_dir_command to "cd " & target_path
				write text change_dir_command
			end if
            write text "clear"
		end tell
	end tell
end run

on split(str, delimiter)
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delimiter
	set theArray to every text item of str
	set AppleScript's text item delimiters to oldDelimiters
	return theArray
end split