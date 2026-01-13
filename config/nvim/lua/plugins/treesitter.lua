return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "vim",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "markdown",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      -- REMOVE autotag from here - it's now in its own plugin file
    })
  end,
}
