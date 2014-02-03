on run command
    set options to my split(command as string, "|")
    set num to count options
    set action_number to item 1 of options
    set session_name to item 2 of options
    tell application "Path Finder"
        set target_path to "\"" & (the POSIX path of the target of the front finder window) & "\""
        set change_dir_command to "cd " & target_path
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
                delay 0.1
                keystroke action_number
                keystroke return
                if action_number = "2" then
                    delay 0.1
                    keystroke session_name
                    keystroke return
                end if
            end tell
            delay 0.1
            write text change_dir_command
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