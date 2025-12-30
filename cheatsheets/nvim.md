# Neovim Complete Reference Card (with LSP)

## 🚨 Most Important Commands
**Exit Neovim:** `Esc` then `:q!` (quit without saving)
**Save:** `Esc` then `:w` or `Space+w`

---

## Modes Quick Reference

| Mode | Enter | Purpose | Indicator |
|------|-------|---------|-----------|
| **NORMAL** | `Esc` | Navigate, delete, copy | Default |
| **INSERT** | `i`, `a`, `o` | Type text | `-- INSERT --` |
| **VISUAL** | `v`, `V` | Select text | `-- VISUAL --` |
| **COMMAND** | `:` | Run commands | `:` at bottom |

---

## Movement (NORMAL mode)

### Basic Navigation
```
     k (up)
     ↑
h ← [cursor] → l
     ↓
     j (down)
```

### Word & Line Movement
| Key | Action |
|-----|--------|
| `w` | Next word start |
| `b` | Previous word start |
| `e` | Next word end |
| `0` | Start of line |
| `^` | First non-blank character |
| `$` | End of line |
| `gg` | Top of file |
| `G` | Bottom of file |
| `5G` or `:5` | Go to line 5 |
| `%` | Jump to matching bracket |
| `Ctrl+u` | Scroll up half page |
| `Ctrl+d` | Scroll down half page |
| `Ctrl+o` | Jump back (previous location) |
| `Ctrl+i` | Jump forward (next location) |

---

## Entering INSERT Mode

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at start of line |
| `A` | Insert at end of line |
| `o` | New line below |
| `O` | New line above |

---

## Editing (NORMAL mode)

### Delete
| Key | Action |
|-----|--------|
| `x` | Delete character |
| `dd` | Delete line |
| `dw` | Delete word |
| `d$` or `D` | Delete to end of line |
| `d0` | Delete to start of line |
| `diw` | Delete inside word |
| `di"` | Delete inside quotes |
| `di{` | Delete inside braces |

### Copy (Yank) & Paste
| Key | Action |
|-----|--------|
| `yy` | Copy line |
| `yw` | Copy word |
| `y$` | Copy to end of line |
| `yiw` | Copy inside word |
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Change (Delete + Insert)
| Key | Action |
|-----|--------|
| `cw` | Change word |
| `cc` | Change entire line |
| `ciw` | Change inside word |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |

### Other Essential
| Key | Action |
|-----|--------|
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last command |
| `r` | Replace single character |
| `>>` | Indent line |
| `<<` | Unindent line |
| `==` | Auto-indent line |
| `J` | Join line below to current |

---

## Visual Mode & Selection 

| Key | Action |
|-----|--------|
| `v` | Visual character mode |
| `V` | Visual line mode |
| `Ctrl+v` | Visual block mode |
| `o` | Toggle cursor to other end |
| `gv` | Reselect last selection |

**After selecting:**
| Key | Action |
|-----|--------|
| `d` | Delete selection |
| `y` | Copy selection |
| `c` | Change selection |
| `>` | Indent |
| `<` | Unindent |
| `=` | Auto-indent |

---
Creating cursors:

Ctrl-n - select word under cursor, then press again to select next occurrence
Ctrl-Down/Up - create cursors vertically (column mode)
\\A - select all occurrences of word under cursor
\\/ - start regex search to create cursors

Once you have multiple cursors:

n/N - skip/go back to next occurrence
q - skip current and get next
Q - remove current cursor
Tab - switch between cursor and extend mode
Press Esc to exit multi-cursor mode

## Search & Replace

### Search
| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor forward |
| `#` | Search word under cursor backward |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace with confirmation |
| `:s/old/new/g` | Replace in current line |

---

## File Operations & Navigation

### Basic File Commands
| Command | Action |
|---------|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` or `:x` | Save and quit |
| `:q!` | Quit without saving |
| `ZZ` | Save and quit |
| `ZQ` | Quit without saving |
| `:e filename` | Open file |
| `:e!` | Reload file (discard changes) |

### Buffer Management
| Command | Action |
|---------|--------|
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `:bd` | Close buffer |
| `:ls` or `:buffers` | List buffers |
| `:b filename` | Switch to buffer |

### Window Management
| Key | Action |
|-----|--------|
| `Ctrl+w s` or `:sp` | Horizontal split |
| `Ctrl+w v` or `:vsp` | Vertical split |
| `Ctrl+w q` or `:q` | Close window |
| `Ctrl+w =` | Equal size windows |
| `Ctrl+w _` | Maximize height |
| `Ctrl+w |` | Maximize width |

---

## 🎯 Your Custom Shortcuts

### Leader Key = `Space`

### File Management
| Shortcut | Action |
|----------|--------|
| `Space + e` | Toggle file explorer (NvimTree) |
| `Space + w` | Save file |
| `Space + q` | Quit |
| `Space + ff` | Find files (fuzzy search) |
| `Space + fg` | Search text in files (grep) |
| `Space + fb` | List open buffers |

### Window Navigation
| Shortcut | Action |
|----------|--------|
| `Ctrl + h` | Move to left window |
| `Ctrl + j` | Move to down window |
| `Ctrl + k` | Move to up window |
| `Ctrl + l` | Move to right window |

---

## 🚀 LSP Features (TypeScript/JavaScript)

### Code Navigation
| Key | Action | Example Use |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to function/variable definition |
| `K` | Show hover info | See type, documentation |
| `gr` | Go to references | Find all usages |
| `gi` | Go to implementation | Jump to implementation |

### Error Navigation
| Key | Action |
|-----|--------|
| `]d` | Next diagnostic/error |
| `[d` | Previous diagnostic/error |
| `Space + d` | Show error details (float) |
| `Space + xx` | Open error list (all files) |
| `Space + xd` | Open errors (current file only) |

### Code Actions
| Key | Action | Example Use |
|-----|--------|-------------|
| `Space + r` | Rename symbol | Rename variable across files |
| `Space + ca` | Code actions | Auto-import, quick fixes |

### LSP Info
| Command | Action |
|---------|--------|
| `:LspInfo` | Show LSP status |
| `:LspRestart` | Restart LSP server |
| `:Mason` | Open package manager |

---

## ⚡ Autocompletion

When suggestions appear:

| Key | Action |
|-----|--------|
| `Tab` | Next suggestion |
| `Shift + Tab` | Previous suggestion |
| `Enter` | Accept suggestion |
| `Ctrl + Space` | Manually trigger completion |
| `Ctrl + e` | Close completion menu |

**Tailwind CSS:** Type `bg-` and get class suggestions!
**TypeScript:** Get method/property suggestions as you type

---

## 📦 File Explorer (NvimTree)

Open with `Space + e`, then:

| Key | Action |
|-----|--------|
| `j` / `k` | Move down/up |
| `Enter` | Open file/folder |
| `h` | Close folder / go up |
| `l` | Open folder / open file |
| `a` | Create new file |
| `d` | Delete file |
| `r` | Rename file |
| `x` | Cut file |
| `c` | Copy file |
| `p` | Paste file |
| `y` | Copy file name |
| `Y` | Copy relative path |
| `gy` | Copy absolute path |
| `R` | Refresh tree |
| `g?` | Show help |
| `q` | Close explorer |
| `Ctrl + h` | Switch to editor window |
| `Ctrl + l` | Switch back to tree |

---

## 🔍 Telescope (Fuzzy Finder)

Open with `Space + ff` (find files) or `Space + fg` (search text):

| Key | Action |
|-----|--------|
| `Ctrl + n` | Next result |
| `Ctrl + p` | Previous result |
| `Enter` | Open file |
| `Ctrl + x` | Open in horizontal split |
| `Ctrl + v` | Open in vertical split |
| `Ctrl + t` | Open in new tab |
| `Esc` or `Ctrl + c` | Close |
| Type to search | Filter results in real-time |

---

## 💬 Comments

| Key | Action |
|-----|--------|
| `gcc` | Comment/uncomment line |
| `gc` (in visual) | Comment/uncomment selection |
| `gcap` | Comment paragraph |

---

## 📝 Multi-line Editing (Visual Block)

1. `Ctrl + v` - Enter visual block mode
2. `j` / `k` - Select multiple lines
3. `I` - Insert at start of all lines
4. Type your text
5. `Esc` - Apply to all lines

---

## 🔧 Useful Commands

### Terminal
| Command | Action |
|---------|--------|
| `:term` | Open terminal |
| `Ctrl + \ Ctrl + n` | Exit terminal mode |
| `i` or `a` | Re-enter terminal mode |

### Help
| Command | Action |
|---------|--------|
| `:help keyword` | Get help |
| `:help lsp` | LSP help |
| `:Tutor` | Interactive tutorial |

### Miscellaneous
| Command | Action |
|---------|--------|
| `:cd path` | Change directory |
| `:pwd` | Show current directory |
| `!command` | Run shell command |
| `:source %` | Reload current file (for config) |
| `:checkhealth` | Check Neovim health |

---

## 🎨 TypeScript/React Workflow

### Opening a Project
```bash
cd ~/your-project
nvim .
```

### Daily Workflow
1. **Open file tree:** `Space + e`
2. **Quick find file:** `Space + ff`, type name
3. **Search in project:** `Space + fg`, type text
4. **Navigate code:**
   - `gd` to jump to definitions
   - `K` to see types/docs
   - `]d` to check errors
5. **Edit and save:** `Space + w`
6. **Rename across files:** `Space + r`

### Tailwind Development
- Type `className="bg-` → Get completions
- Hover over `bg-blue-500` and press `K` → See CSS
- Auto-import works: type component name → `Space + ca` → import

### Error Checking
1. Save file (`Space + w`)
2. Errors show as red squiggles
3. Press `]d` to jump to next error
4. Press `Space + d` to see full error message
5. Press `Space + ca` for quick fixes

---

## 🎯 Pro Tips

### Efficient Navigation
- Use relative line numbers: `5j` jumps 5 lines down
- Use `*` to search for word under cursor
- Use `%` to jump between matching brackets
- Use `Ctrl + o` / `Ctrl + i` to jump back/forward in history

### Efficient Editing
- `.` repeats your last action (super powerful!)
- `ciw` is faster than `diwi` for changing words
- `A` is faster than `$a` for appending to line end
- `o` is faster than `$a` then `Enter` for new lines

### Working with Multiple Files
1. Open project: `nvim .`
2. Find file: `Space + ff`
3. Open multiple files: `Enter` on each
4. Switch between: `Space + fb` then select
5. Or use `:bn` / `:bp` to cycle

### Terminal Workflow
**Tab 1:** Neovim for editing
**Tab 2:** `npm run dev` (dev server)
**Tab 3:** Git commands and testing

Switch tabs with `Ctrl + PageUp` / `Ctrl + PageDown`

---

## 🐛 Common Issues & Solutions

### "LSP not working"
```
:LspInfo        # Check status
:LspRestart     # Restart server
:Mason          # Check installations
```

### "Tailwind suggestions not appearing"
- Make sure you have a `tailwind.config.js` in project root
- Restart LSP: `:LspRestart`

### "Can't type"
- Press `Esc` then `i` to enter INSERT mode

### "Can't save"
- Press `Esc` then `:w`

### "Stuck in weird state"
- Press `Esc` multiple times
- Type `:q!` to quit without saving

### "Want to undo everything"
- Keep pressing `u` to undo
- Or `:e!` to reload file (lose all changes)

---

## 📚 Learning Path

### Week 1: Master Basics
- ✅ `hjkl` navigation
- ✅ `i` / `a` / `o` for insert
- ✅ `dd` / `yy` / `p` for delete/copy/paste
- ✅ `:w` / `:q` for save/quit
- ✅ `Space + e` / `Space + ff` for files

### Week 2: Get Faster
- ✅ Word motions: `w` / `b` / `e`
- ✅ Line motions: `0` / `$` / `^`
- ✅ Visual mode: `v` / `V`
- ✅ `gcc` for comments
- ✅ `.` to repeat commands

### Week 3: Use LSP
- ✅ `gd` to jump to definitions
- ✅ `K` for hover info
- ✅ `]d` / `[d` for error navigation
- ✅ `Space + r` for rename
- ✅ `Space + ca` for code actions

### Week 4+: Advanced
- ✅ Text objects: `ciw`, `ci"`, `di{`
- ✅ Macros: Record with `q`, replay with `@`
- ✅ Marks: Set with `m`, jump with `'`
- ✅ Registers: Store in `"a`, paste with `"ap`
- ✅ Custom keybindings

---

## 🆘 Quick Escape Routes

**I'm lost in a file:** `gg` (top) or `G` (bottom)
**I can't move:** Press `Esc` then use `hjkl`
**I want to undo everything:** Keep pressing `u`
**I want to quit without saving:** `Esc` then `:q!`
**I want to start over:** `:e!` (reload file)
**Something weird happened:** `Esc` `Esc` `Esc` `:q!`

---

## 🎓 Resources

- **Built-in tutorial:** Type `vimtutor` in terminal
- **Interactive:** `:Tutor` inside Neovim
- **Help:** `:help <topic>` (example: `:help lsp`)
- **Plugin docs:** `:help telescope` or `:help nvim-tree`

---

**Remember:** Everyone is slow at first! Give it 2 weeks of daily use. The investment pays off! 🚀
