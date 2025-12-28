return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',    -- Better UI for code actions
    'nvim-telescope/telescope-file-browser.nvim', -- File browser
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        -- Ignore patterns
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "dist/",
          "build/",
          "%.lock",
          "package-lock.json",
        },

        -- Layout
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },

        sorting_strategy = "ascending",

        -- Appearance
        color_devicons = true,
        prompt_prefix = "🔍 ",
        selection_caret = "➜ ",

        -- Performance
        cache_picker = {
          num_pickers = 10,
        },

        -- Keymaps inside Telescope
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-x>"] = actions.delete_buffer,
            ["<esc>"] = actions.close,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["q"] = actions.close,
            ["dd"] = actions.delete_buffer,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
          },
        },
      },

      pickers = {
        -- File pickers
        find_files = {
          hidden = true, -- Show hidden files
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },

        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },

        -- Buffer picker
        buffers = {
          sort_lastused = true,
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
          mappings = {
            i = { ["<C-d>"] = actions.delete_buffer },
            n = { ["dd"] = actions.delete_buffer },
          },
        },

        -- Marks picker
        marks = {
          initial_mode = "normal",
        },

        -- Old files picker
        oldfiles = {
          only_cwd = true, -- Only show files from current directory
        },

        -- Help picker
        help_tags = {
          theme = "ivy",
        },

        -- Colorscheme picker with live preview
        colorscheme = {
          enable_preview = true,
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },

        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },

        file_browser = {
          theme = "ivy",
          hijack_netrw = true, -- Replace netrw with telescope
        },
      },
    })

    -- Load extensions
    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
    telescope.load_extension('file_browser')
  end,
}
