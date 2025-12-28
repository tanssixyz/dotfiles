return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- file icons
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 35,
        side = "left",
      },
      renderer = {
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "›",
              arrow_open = "▾",
            },
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
      filters = {
        dotfiles = false,
        custom = { ".git", "node_modules", ".cache" },
      },
    })
  end,
}
