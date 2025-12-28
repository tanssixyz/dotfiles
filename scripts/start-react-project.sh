#!/bin/bash
PROJECT_PATH="$1"

if [ -z "$PROJECT_PATH" ]; then
    echo "Usage: start-react-project.sh <project-path>"
    exit 1
fi

cd "$PROJECT_PATH" || exit

tmux new-session -d -s dev
tmux rename-window 'dev'
tmux split-window -h -p 35
tmux split-window -v -p 30

# Pane 0: nvim
tmux send-keys -t 0 'nvim .' C-m

# Pane 1: Claude Code (ready to run)
tmux send-keys -t 1 'echo "Run: claude-code"'

# Pane 2: Vite server
tmux send-keys -t 2 'npm run dev' C-m

# New window for git/terminal
tmux new-window -n 'git'

tmux select-window -t 0
tmux select-pane -t 0
tmux attach-session -t dev
