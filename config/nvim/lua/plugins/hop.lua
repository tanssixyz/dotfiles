return {
  "phaazon/hop.nvim",
  branch = "v2",
  config = function()
    require("hop").setup()
  end,
  keys = {
    {
      "s",
      function()
        require("hop").hint_char2()
      end,
      mode = { "n", "x", "o" },
      desc = "Hop to 2 chars",
    },
    {
      "S",
      function()
        require("hop").hint_words()
      end,
      mode = { "n", "x", "o" },
      desc = "Hop to word",
    },
  },
}
