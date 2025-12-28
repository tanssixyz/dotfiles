local keymap = vim.keymap

-- Set leader key
vim.g.mapleader = " "

-- File explorer
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Telescope
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })

-- Split windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close split" })

-- Navigate splits
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Save and quit
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Format file
keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format file" })

-- Comments (Comment.nvim)
-- gcc - comment line (normal mode)
-- gc - comment selection (visual mode)

-- Emmet expand
-- <C-z>, in insert mode (e.g., div.container<C-z>,)

-- Git (Gitsigns)
keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame line" })

-- Disable arrow keys in normal mode (force hjkl)
keymap.set("n", "<Up>", "<Nop>", { desc = "Disabled" })
keymap.set("n", "<Down>", "<Nop>", { desc = "Disabled" })
keymap.set("n", "<Left>", "<Nop>", { desc = "Disabled" })
keymap.set("n", "<Right>", "<Nop>", { desc = "Disabled" })

-- Disable in insert mode too (hardcore mode!)
keymap.set("i", "<Up>", "<Nop>", { desc = "Disabled" })
keymap.set("i", "<Down>", "<Nop>", { desc = "Disabled" })
keymap.set("i", "<Left>", "<Nop>", { desc = "Disabled" })
keymap.set("i", "<Right>", "<Nop>", { desc = "Disabled" })

-- Disable in visual mode
keymap.set("v", "<Up>", "<Nop>", { desc = "Disabled" })
keymap.set("v", "<Down>", "<Nop>", { desc = "Disabled" })
keymap.set("v", "<Left>", "<Nop>", { desc = "Disabled" })
keymap.set("v", "<Right>", "<Nop>", { desc = "Disabled" })

-- Map jj and jk to escape in insert mode
keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode with jj" })
keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })

-- Telescope keymaps
local keymap = vim.keymap

-- File pickers
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
keymap.set("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Find all files" })
keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
keymap.set("n", "<leader>fw", ":Telescope grep_string<CR>", { desc = "Find word under cursor" })
keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "File browser" })

-- Search pickers
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
keymap.set("n", "<leader>fc", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in current buffer" })

-- Buffer/History pickers
keymap.set("n", "<leader>bu", ":Telescope buffers<CR>", { desc = "Buffers" })
keymap.set("n", "<leader>fj", ":Telescope jumplist<CR>", { desc = "Jumplist" })
keymap.set("n", "<leader>fm", ":Telescope marks<CR>", { desc = "Marks" })
keymap.set("n", "<leader>fre", ":Telescope registers<CR>", { desc = "Registers" })

-- Git pickers
keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", { desc = "Git status" })
keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>", { desc = "Git commits" })
keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "Git branches" })

-- LSP pickers
keymap.set("n", "<leader>lr", ":Telescope lsp_references<CR>", { desc = "LSP references" })
keymap.set("n", "<leader>ld", ":Telescope lsp_definitions<CR>", { desc = "LSP definitions" })
keymap.set("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
keymap.set("n", "<leader>lw", ":Telescope diagnostics<CR>", { desc = "Diagnostics" })

-- Vim pickers
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help" })
keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
keymap.set("n", "<leader>fo", ":Telescope vim_options<CR>", { desc = "Vim options" })
keymap.set("n", "<leader>ft", ":Telescope colorscheme<CR>", { desc = "Colorscheme" })
keymap.set("n", "<leader>cmd", ":Telescope commands<CR>", { desc = "Commands" })
