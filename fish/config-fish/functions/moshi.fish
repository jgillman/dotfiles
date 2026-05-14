function moshi --description 'Open or attach to a tmux session for DIR (default $PWD)'
    set -l dir $argv[1]
    test -z "$dir"; and set dir $PWD

    if not test -d "$dir"
        echo "Directory not found: $dir" >&2
        return 1
    end

    set -l abs (cd "$dir"; and pwd)

    set -l session (basename "$abs" | tr -cs '[:alnum:]_-' '-')
    set session (string trim --chars=- -- $session)
    test -n "$session"; or set session main

    if not tmux has-session -t "$session" 2>/dev/null
        tmux new-session -d -s "$session" -c "$abs" -n agent
        tmux new-window -t "$session":2 -c "$abs" -n review
        tmux new-window -t "$session":3 -c "$abs" -n tests
        tmux new-window -t "$session":4 -c "$abs" -n servers
        tmux new-window -t "$session":5 -c "$abs" -n misc
    end

    tmux attach -t "$session"
end
