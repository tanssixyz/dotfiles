# Neovim Quick Reference Card

## 🚨 Most Important Command
**Exit Neovim:** `Esc` then `:q!` (quit without saving)

---

## Modes (Understanding This is Key!)

| Mode | How to Enter | What It's For | Visual Indicator |
|------|--------------|---------------|------------------|
| **NORMAL** | `Esc` | Navigate, delete, copy | Default mode |
| **INSERT** | `i`, `a`, `o` | Type text like normal editor | `-- INSERT --` |
| **VISUAL** | `v`, `V` | Select text | `-- VISUAL --` |
| **COMMAND** | `:` | Run commands | `:` at bottom |

**Remember:** Press `Esc` to get back to NORMAL mode from anywhere!

---

## Basic Movement (NORMAL mode)

### Character/Line Movement
```
     k (up)
     ↑
h ← [cursor] → l
     ↓
     j (down)
```

### Word Movement
| Key | Action |
|-----|--------|
| `w` | Next word start |
| `b` | Previous word start |
| `e` | Next word end |
| `0` | Start of line |
| `^` | First non-blank character |
| `$` | End of line |

### File Navigation
| Key | Action |
|-----|--------|
| `gg` | Top of file |
| `G` | Bottom of file |
| `5G` | Go to line 5 |
| `Ctrl+u` | Scroll up half page |
| `Ctrl+d` | Scroll down half page |
| `%` | Jump to matching bracket |

---

## Entering INSERT Mode

| Key | What It Does |
|-----|--------------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at start of line |
| `A` | Insert at end of line |
| `o` | New line below |
| `O` | New line above |

**Remember:** Press `Esc` to return to NORMAL mode!

---

## Editing (NORMAL mode)

### Delete
| Key | Action |
|-----|--------|
| `x` | Delete character under cursor |
| `dd` | Delete entire line |
| `dw` | Delete word |
| `d$` | Delete to end of line |
| `d0` | Delete to start of line |

### Copy (Yank)
| Key | Action |
|-----|--------|
| `yy` | Copy entire line |
| `yw` | Copy word |
| `y$` | Copy to end of line |

### Paste
| Key | Action |
|-----|--------|
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Other
| Key | Action |
|-----|--------|
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last command |
| `r` | Replace single character |
| `cw` | Change word (delete and enter INSERT) |
| `cc` | Change entire line |
| `>>` | Indent line |
| `<<` | Unindent line |

---

## Visual Mode

| Key | Action |
|-----|--------|
| `v` | Start visual mode (character) |
| `V` | Start visual mode (line) |
| `Ctrl+v` | Start visual block mode |
| Move with `hjkl` | Expand selection |
| `d` | Delete selection |
| `y` | Copy selection |
| `>` | Indent selection |
| `<` | Unindent selection |

---

## Search & Replace

### Search
| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor |

### Replace
| Command | Action |
|---------|--------|
| `:s/old/new/` | Replace first on line |
| `:s/old/new/g` | Replace all on line |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirmation |

---

## File Operations

### Save & Quit
| Command | Action |
|---------|--------|
| `:w` | Save |
| `:q` | Quit (fails if unsaved) |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |
| `:x` | Save and quit (only if changed) |
| `ZZ` | Save and quit (from NORMAL) |
| `ZQ` | Quit without saving (from NORMAL) |

### File Management
| Command | Action |
|---------|--------|
| `:e filename` | Open file |
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `:bd` | Close buffer |
| `:ls` | List buffers |

---

## Your Custom Shortcuts (from config)

### Leader Key = `Space`

| Shortcut | Action |
|----------|--------|
| `Space + e` | Toggle file explorer |
| `Space + w` | Save file |
| `Space + q` | Quit |
| `Space + ff` | Find files (fuzzy search) |
| `Space + fg` | Search text in files (grep) |
| `Space + fb` | List open buffers |

### Window Navigation
| Shortcut | Action |
|----------|--------|
| `Ctrl+h` | Move to left window |
| `Ctrl+j` | Move to down window |
| `Ctrl+k` | Move to up window |
| `Ctrl+l` | Move to right window |

### Window Management
| Command | Action |
|---------|--------|
| `:sp filename` | Horizontal split |
| `:vsp filename` | Vertical split |
| `Ctrl+w q` | Close window |
| `Ctrl+w =` | Equal size windows |

---

## File Explorer (NvimTree)

Once open with `Space + e`:

| Key | Action |
|-----|--------|
| `j/k` | Move down/up |
| `Enter` | Open file/folder |
| `h` | Close folder |
| `l` | Open folder |
| `a` | Create file |
| `d` | Delete file |
| `r` | Rename file |
| `y` | Copy file name |
| `g?` | Show help |
| `q` | Close tree |

---

## Telescope (Fuzzy Finder)

Once open with `Space + ff`:

| Key | Action |
|-----|--------|
| `Ctrl+n` | Next result |
| `Ctrl+p` | Previous result |
| `Enter` | Open file |
| `Esc` | Close |
| Start typing | Filter results |

---

## Terminal Inside Neovim

| Command | Action |
|---------|--------|
| `:term` | Open terminal |
| `Ctrl+\ Ctrl+n` | Exit terminal mode |
| `i` or `a` | Enter terminal mode |

---

## Helpful Commands

| Command | Action |
|---------|--------|
| `:help keyword` | Get help on anything |
| `:set number` | Show line numbers |
| `:set nonumber` | Hide line numbers |
| `:!command` | Run shell command |
| `:cd path` | Change directory |
| `:pwd` | Show current directory |

---

## Common React Dev Workflow

1. **Open project:**
   ```bash
   cd ~/project
   nvim .
   ```

2. **Navigate files:**
   - `Space + e` → Open file tree
   - `Space + ff` → Quick file search
   - Navigate with `j/k`, open with `Enter`

3. **Edit code:**
   - `i` to start typing
   - `Esc` when done
   - `Space + w` to save

4. **Search in project:**
   - `Space + fg` → Search text
   - Type search term
   - `Enter` to open file

5. **Run dev server in separate tab:**
   - Open new terminal tab
   - `npm run dev`
   - Switch back to Neovim tab

---

## Beginner Tips

1. **Use `hjkl` instead of arrow keys** - It feels weird at first but becomes natural
2. **Stay in NORMAL mode** - Only enter INSERT when actually typing
3. **Press `Esc` liberally** - When confused, `Esc` gets you back to safety
4. **Use `u` for undo** - Don't fear mistakes, just undo them
5. **Learn incrementally** - Master one section at a time
6. **Relative line numbers are your friend** - Use `5j` to jump 5 lines down

---

## Practice Exercises

### Exercise 1: Basic Navigation
1. Open a file: `nvim test.txt`
2. Press `i` and type some lines
3. Press `Esc` and use `j/k` to move around
4. Jump to top with `gg`, bottom with `G`
5. Quit with `:q!`

### Exercise 2: Edit & Save
1. Open file: `nvim test.txt`
2. Press `o` to create new line
3. Type something, press `Esc`
4. Press `dd` to delete a line
5. Save with `:w`

### Exercise 3: Copy & Paste
1. Press `yy` to copy a line
2. Move down with `j`
3. Press `p` to paste
4. Try `3yy` to copy 3 lines

### Exercise 4: Search & Replace
1. Type `/word` to search
2. Press `n` to find next match
3. Try `:%s/old/new/g` to replace all

---

## When You're Stuck

- **Can't type?** → Press `Esc`, then `i`
- **Can't save?** → Type `:w` and press `Enter`
- **Can't quit?** → Type `:q!` and press `Enter`
- **Weird behavior?** → Press `Esc` a few times
- **Completely lost?** → Close terminal and restart

---

## Next Steps After Mastering Basics

1. ✅ Master basic movement (hjkl, w, b)
2. ✅ Get comfortable with i/a/o and Esc
3. ✅ Learn dd, yy, p
4. 📚 Learn visual mode (v, V)
5. 📚 Add LSP for autocomplete & go-to-definition
6. 📚 Learn macros (record with `q`)
7. 📚 Learn text objects (ciw, di", etc.)
8. 📚 Customize more keybindings

---

## Useful Resources

- `:help` - Built-in help (super comprehensive)
- `:Tutor` - Interactive tutorial
- `vimtutor` - Command-line tutorial (type in bash)

**Remember:** Everyone is slow at first. Give it 2 weeks of daily use before judging whether it's for you!
