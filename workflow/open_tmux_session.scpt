on run command
    do shell script "echo '" & command & "' >> log.txt"

	set options to my split(command as string, "|")
	set iterm_running to (item 1 of options) as integer
	set session_name to item 2 of options
	set session_create to item 3 of options
	set change_dir to (item 4 of options) as integer


	tell application "iTerm"
		activate
		set termCount to count of terminals
		
		if termCount is 0 then
			set _term to (make new terminal)
		else
			if iterm_running > 0 then
				set _term to the first terminal
				tell i term application "System Events" to tell process "Terminal.app" to keystroke "t" using command down
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
		    if session_create > 0 then
                write text "tmux new-session -s \"" & session_name & "\""
            else
                write text "tmux attach -t \"" & session_name & "\""
		    end if
		    delay 1
			if change_dir > 0 then
				tell i term application "Path Finder"
					set target_path to "\"" & (the POSIX path of the target of the front finder window) & "\""
					set change_dir_command to "cd " & target_path
				end tell
				delay 0.1
				write text change_dir_command
				write text "clear"
			end if
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