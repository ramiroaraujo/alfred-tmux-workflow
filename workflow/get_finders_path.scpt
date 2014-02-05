tell application "Path Finder"
    set target_path to "\"" & (the POSIX path of the target of the front finder window) & "\""
    return target_path
end tell