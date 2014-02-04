#!/bin/sh
export PATH=$PATH:/usr/local/bin

# abort if we're already inside a TMUX session
[ "$TMUX" == "" ] || exit 0

# startup a "default" session if none currently exists
tmux has-session -t default || tmux new-session -s default -d

# order sessions, so that order is default, new session, zsh, and then another existent sessions
IFS='|||'
read -a sessions <<< "$(tmux list-sessions -F "#S" | tr '\n' '|||')"
options=(default 'new session' zsh)
for i in "${sessions[@]}"; do :
   if [[ ${i} != "default" ]]; then options=("${options[@]}" "$i"); fi
done

# present menu for user to choose which workspace to open
PS3="Please choose your session: "
echo "Available sessions"
echo "------------------"
echo " "
select opt in "${options[@]}"
do
    case ${opt} in
        "new session")
            read -p "Enter new session name: " SESSION_NAME
            tmux new -s "$SESSION_NAME"
            break
            ;;
        "zsh")
            zsh
            break;;
        *)
            tmux attach-session -t ${opt}
            break
            ;;
    esac
done