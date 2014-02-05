if application "Path Finder" is running then
    tell application "Path Finder"
        set target_path to "\"" & (the POSIX path of the target of the front finder window) & "\""
        return target_path
    end tell
else
tell application "Finder"
		set target_path to (quoted form of POSIX path of (folder of the front window as alias))
		return target_path
	end tell
end if

