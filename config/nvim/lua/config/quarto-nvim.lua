-- Configuration for quarto-nvim
-- See: https://github.com/quarto-dev/quarto-nvim

local quarto = require("quarto")

quarto.setup({
  debug = false,
  closePreviewOnExit = true,
  lspFeatures = {
    enabled = true,
    -- NOTE: Configure languages you want LSP features for
    languages = { "r", "python", "julia", "bash", "lua", "html", "javascript" },
    chunks = "all", -- 'curly' or 'all'
    diagnostics = {
      enabled = true,
      triggers = { "BufWritePost" },
    },
    completion = {
      enabled = true,
    },
  },
  codeRunner = {
    enabled = true,
    default_method = "molten", -- 'molten' or 'slime'
    ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
    never_run = { "yaml" }, -- filetypes which are never sent to a code runner
  },
  keymap = {
    -- NOTE: Set up your own keymaps (these are defaults for hover and definition)
    hover = "K",
    definition = "gd",
    type_definition = "gD",
    rename = "<leader>rn",
    format = "<leader>gf",
    references = "gr",
    document_symbols = "gS",
  },
})

-- Keybindings for quarto code runner
local runner = require("quarto.runner")
local keymap = vim.keymap

keymap.set("n", "<localleader>rc", runner.run_cell, {
  desc = "run cell",
  silent = true,
})

keymap.set("n", "<localleader>ra", runner.run_above, {
  desc = "run cell and above",
  silent = true,
})

keymap.set("n", "<localleader>rA", runner.run_all, {
  desc = "run all cells",
  silent = true,
})

keymap.set("n", "<localleader>rl", runner.run_line, {
  desc = "run line",
  silent = true,
})

keymap.set("v", "<localleader>r", runner.run_range, {
  desc = "run visual range",
  silent = true,
})

keymap.set("n", "<localleader>RA", function()
  runner.run_all(true)
end, {
  desc = "run all cells of all languages",
  silent = true,
})
