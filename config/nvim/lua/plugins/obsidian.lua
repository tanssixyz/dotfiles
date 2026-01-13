return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/obsidian/personal",
      },
    },
     ui = {
      enable = false,  -- Disable UI features to suppress warning
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      template = "daily.md",
    },
    -- Use simple title-based IDs
    note_id_func = function(title)
      return title
    end,

    -- Disable frontmatter if you want pure markdown
    disable_frontmatter = false,

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- Telescope integration (automatic when telescope is installed)
    picker = {
      name = "telescope.nvim",
    },

    -- Where to put attachments
    attachments = {
      img_folder = "attachments",
    },
  },

  keys = {
    { "<leader>on", ":ObsidianNew<CR>",                       desc = "New note" },
    { "<leader>oo", ":ObsidianSearch<CR>",                    desc = "Search notes" },
    { "<leader>oq", ":ObsidianQuickSwitch<CR>",               desc = "Quick switch" },
    { "<leader>ot", ":ObsidianToday<CR>",                     desc = "Today's note" },
    { "<leader>ob", ":ObsidianBacklinks<CR>",                 desc = "Backlinks" },
    { "<leader>ol", ":ObsidianLink<CR>",                      desc = "Link to note" },
    { "<leader>of", ":ObsidianFollowLink<CR>",                desc = "Follow link" },
    { "<leader>oc", ":ObsidianNew Quick-Capture<CR>",         desc = "Quick capture" },
    -- Quick navigation to folders
    { "<leader>oP", ":e ~/obsidian/personal/1-Projects<CR>",  desc = "Projects folder" },
    { "<leader>oA", ":e ~/obsidian/personal/2-Areas<CR>",     desc = "Areas folder" },
    { "<leader>oR", ":e ~/obsidian/personal/3-Resources<CR>", desc = "Resources folder" },
    { "<leader>oI", ":e ~/obsidian/personal/index.md<CR>",    desc = "Index/Home" },
  },
}
