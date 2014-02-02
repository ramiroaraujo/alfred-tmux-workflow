on run query
	tell application "Path Finder"
		if (first item of query) is "" then
			set targetPath to "\"" & (the POSIX path of the target of the front finder window) & "\""
		else
			set targetPath to first item of query
		end if
		
		set theCommand to "cd " & targetPath
	end tell
	
	tell application "System Events" to set terminalIsRunning to exists application process "iTerm"
	
	tell application "iTerm"
		activate
		
		try
			set _session to current session of current terminal
		on error
			set _term to (make new terminal)
			tell _term
				launch session "Default"
				set _session to current session
			end tell
		end try
		
		tell _session
			tell i term application "System Events"
				keystroke "1"
				keystroke return
			end tell
			delay 0.2
			write text theCommand
			write text "clear"
		end tell
	end tell
end run