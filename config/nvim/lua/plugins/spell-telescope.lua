return {
  'nvim-telescope/telescope.nvim',
  keys = {
    {
      "<leader>ss",
      function()
        require('telescope.builtin').spell_suggest(require('telescope.themes').get_cursor())
      end,
      desc = "Spell suggestions",
    },
  },
}
