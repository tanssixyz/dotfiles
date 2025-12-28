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
        "tsx",           -- React/JSX
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
      autotag = {
        enable = true,  -- Auto close tags
      },
    })
  end,
}
