require("luasnip.loaders.from_vscode").lazy_load()
  -- Setup keymaps
require 'luasnip'.filetype_extend("ruby", { "rails" })
require 'luasnip'.filetype_extend("go", { "go" })
