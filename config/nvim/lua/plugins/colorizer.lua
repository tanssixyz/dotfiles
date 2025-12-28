return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "html",
    }, {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      tailwind = true,
    })
  end,
}
