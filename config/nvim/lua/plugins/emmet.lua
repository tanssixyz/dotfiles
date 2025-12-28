return {
  "mattn/emmet-vim",
  ft = { "html", "css", "javascriptreact", "typescriptreact" },
  init = function()
    vim.g.user_emmet_leader_key = "<C-z>"
    vim.g.user_emmet_settings = {
      javascript = {
        extends = "jsx",
      },
      typescript = {
        extends = "tsx",
      },
    }
  end,
}
