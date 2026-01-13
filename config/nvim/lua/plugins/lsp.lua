return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls", -- Changed from tsserver (new name)
        "tailwindcss",
        "html",
        "cssls",
        "eslint",
      },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- New way (no more lspconfig variable)
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- TypeScript/JavaScript
    vim.lsp.enable("ts_ls")

    -- Tailwind CSS
    vim.lsp.enable("tailwindcss")

    -- HTML
    vim.lsp.enable("html")

    -- CSS
    vim.lsp.enable("cssls")

    -- ESLint
    vim.lsp.enable("eslint")

    -- Lua
    vim.lsp.enable("lua_ls")

    -- Keybindings for LSP
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })
  end,
}
