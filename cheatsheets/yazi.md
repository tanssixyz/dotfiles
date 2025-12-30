# Neovim Navigation Cheatsheet

## Quick Access

- `<space>e` - Toggle nvim-tree (quick file navigation)
- `<space>y` - Open Yazi at current file (power file manager)
- `<space>Y` - Open Yazi in working directory

## Telescope (Fuzzy Finding)

- `<space>ff` - Find files
- `<space>fg` - Live grep (search in files)
- `<space>fb` - Browse buffers
- `<space>fh` - Help tags
- `<space>fo` - Old files (recent)

## nvim-tree Navigation

- `h/j/k/l` - Navigate
- `<Enter>` - Open file/folder
- `a` - Create new file
- `d` - Delete file
- `r` - Rename file
- `x` - Cut file
- `c` - Copy file
- `p` - Paste file
- `R` - Refresh tree
- `q` or `<space>e` - Close tree

## Yazi Power Mode

### Navigation

- `h/j/k/l` or arrows - Navigate files
- `Enter` - Open in Neovim
- `q` - Quit back to Neovim
- `f1` - Help menu

### File Operations

- `yy` - Copy (yank) file
- `dd` - Cut file
- `pp` - Paste file
- `a` - Create file
- `o` - Open with default app
- `e` - Edit in $EDITOR

### Selection & Bulk

- `Space` - Select/deselect file
- `v` - Visual mode (select multiple)
- `V` - Select all
- `Ctrl-a` - Select all
- `Ctrl-r` - Clear selection

### View & Search

- `z` - Toggle hidden files
- `/` - Search files
- `s` - Sort menu
- `Tab` - Preview toggle
- `;` - Run shell command

### Advanced

- `r` - Batch rename
- `X` - Delete permanently
- `c` - Change directory
- `~` - Go to home
- `g` - Go to top
- `G` - Go to bottom

## Workflow Tips

1. **Quick edits**: Use `<space>e` for nvim-tree
2. **Bulk operations**: Use `<space>y` for Yazi (move/copy many files)
3. **Finding files**: Use Telescope `<space>ff`
4. **Search content**: Use Telescope `<space>fg`
