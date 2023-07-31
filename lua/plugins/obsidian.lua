return {
  "epwalsh/obsidian.nvim",
  lazy = false,
  event = { "BufReadPre /home/kkpagaev/Documents/Obsidian Vault/**.md" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    -- "vimwiki/vimwiki",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>nu",      "<cmd>ObsidianSearch<CR>",  desc = "Find a string", silent = true },
    -- { "<leader>n",      "<cmd>Telescope commands<CR>",  desc = "Find a string", silent = true },
    { "<leader>on",     ":ObsidianNew ",  desc = "Help",          silent = false },
    { "<leader>ob",     "<cmd>ObsidianBacklinks<CR>",  desc = "Help",          silent = false },
    { "<leader>ow",     "<cmd>ObsidianFollowLink<CR>",  desc = "Help",          silent = false },
    { "<leader>ot",     "<cmd>ObsidianTemplate<CR>", desc = "Find Git",      silent = true },
    { "<leader>ou",     "<cmd>ObsidianQuickSwitch<CR>", desc = "Find Git",      silent = true },
  },

  opts = {
    dir = "~/Documents/Obsidian Vault", -- no need to call 'vim.fn.expand' here
    completion = {
      nvim_cmp = true,
      new_notes_location = "current_dir",
      prepend_note_id = true
    },

      -- Optional, customize how names/IDs for new notes are created.
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end,
    templates = {
      subdir = "999 Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M"
    },

    -- see below for full list of options 👇
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    local au = vim.api.nvim_create_autocmd

    au('BufRead', {
      pattern = '*.md',
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.keymap.set("n", "ge", function()
          if require("obsidian").util.cursor_on_markdown_link() then
            return "<cmd>ObsidianFollowLink<CR>"
          else
            return "ge"
          end
        end, { noremap = false, expr = true, buffer = bufnr, remap = false  })
      end,
    })
    -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
    -- see also: 'follow_url_func' config option below.
  end,
}
