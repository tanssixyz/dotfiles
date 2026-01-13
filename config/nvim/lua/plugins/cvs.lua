return {
  'chrisbra/csv.vim',
  ft = { 'csv', 'tsv' },
  config = function()
    vim.g.csv_delim = ';'
    vim.g.csv_autocmd_arrange = 1
    vim.g.csv_highlight_column = 'y'

    -- Auto-arrange on CSV file open
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "csv",
      callback = function()
        vim.cmd("CSVInit")
        vim.cmd("ArrangeColumn")
      end,
    })
  end
}
