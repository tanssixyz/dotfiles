# Git Reference - Quick Guide

## Core Concepts

**Three Areas:**
- Working Directory → where you edit files
- Staging Area (Index) → files ready for next commit  
- Repository (.git) → committed history

**Workflow:**
```
Working → [git add] → Staging → [git commit] → Repository → [git push] → Remote
```

## Essential Commands

### Starting a Repo
```bash
# Create new repo
git init

# Clone existing
git clone git@github.com:user/repo.git
gh repo clone user/repo  # with GitHub CLI
```

### Daily Workflow
```bash
# Check status
git status

# Stage files
git add filename           # Single file
git add .                 # All files in directory
git add -p                # Interactive staging (review hunks)

# Commit
git commit -m "message"   # With message
git commit                # Opens editor for message
git commit -am "message"  # Stage + commit (tracked files only)

# Push to remote
git push origin main
git push                  # If upstream is set

# Pull from remote
git pull origin main
git pull                  # If upstream is set
```

### Viewing History
```bash
# View commits
git log                           # Full log
git log --oneline                 # Compact view
git log --oneline --graph --all   # Visual tree of all branches

# View changes
git diff                  # Unstaged changes
git diff --staged         # Staged changes
git diff HEAD             # All changes vs last commit
git diff main..feature    # Between branches
```

### Branching
```bash
# Create branch
git branch feature-name           # Create only
git checkout -b feature-name      # Create and switch
git switch -c feature-name        # Modern syntax

# Switch branches
git checkout main
git switch main           # Modern syntax

# List branches
git branch               # Local branches
git branch -a            # All branches (including remote)

# Delete branch
git branch -d feature-name        # Safe delete (merged only)
git branch -D feature-name        # Force delete
```

### Merging
```bash
# Merge branch into current
git merge feature-name

# Abort merge if conflicts
git merge --abort
```

### Undoing Changes
```bash
# Discard unstaged changes
git restore filename              # Single file
git restore .                     # All files

# Unstage files
git restore --staged filename     # Unstage specific file
git reset HEAD filename           # Old syntax

# Amend last commit
git commit --amend                # Fix message or add forgotten files
git commit --amend --no-edit      # Keep same message

# Undo commits (dangerous!)
git reset --soft HEAD~1   # Undo commit, keep changes staged
git reset --mixed HEAD~1  # Undo commit, unstage changes
git reset --hard HEAD~1   # Undo commit, discard changes (DANGEROUS!)

# Safe undo (creates new commit)
git revert commit-hash
```

### Stashing (Save Work in Progress)
```bash
# Save current changes
git stash
git stash save "description"

# List stashes
git stash list

# Apply stash
git stash pop             # Apply and remove from stash
git stash apply           # Apply but keep in stash

# Delete stash
git stash drop
git stash clear           # Remove all stashes
```

### Remote Operations
```bash
# View remotes
git remote -v

# Add remote
git remote add origin git@github.com:user/repo.git

# Change remote URL
git remote set-url origin git@github.com:user/repo.git

# Fetch (download without merging)
git fetch origin

# Pull (fetch + merge)
git pull origin main
```

## Dotfiles Workflow
```bash
# My custom aliases
dotfiles              # cd ~/dotfiles && git status
dotcommit "message"   # cd ~/dotfiles && git add -A && git commit -m "message"
dotpush               # cd ~/dotfiles && git push

# Make changes to configs
nvim ~/.bashrc        # Edit symlinked file

# Commit changes
dotfiles              # Check what changed
dotcommit "bash: add new alias"
dotpush
```

## Branch Workflow Pattern
```bash
# Start new feature
git switch main                    # Make sure you're on main
git pull                          # Get latest changes
git switch -c feature-name        # Create feature branch

# Work on feature
# ... edit files ...
git add .
git commit -m "implement feature"

# Keep feature updated with main (if main changed)
git switch main
git pull
git switch feature-name
git merge main                    # Or: git rebase main

# Finish feature
git switch main
git merge feature-name            # Merge into main
git push

# Clean up
git branch -d feature-name        # Delete local branch
```

## Project Setup Pattern
```bash
# Create new project
mkdir project-name
cd project-name
git init

# Create .gitignore
cat > .gitignore << 'EOF'
# Compiled files
*.o
*.out
executable_name

# Editor
*.swp
*~

# Dependencies (for C projects)
*.a

# For web projects
node_modules/
.env
