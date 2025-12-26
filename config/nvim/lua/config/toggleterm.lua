local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<C-\>]],
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  persist_mode = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

-- Terminal keybindings
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- Apply terminal keymaps when entering terminal mode
vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

-- Custom terminal instances
local Terminal = require("toggleterm.terminal").Terminal

-- Lazygit terminal
local lazygit = Terminal:new {
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "curved",
  },
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  on_close = function(term)
    vim.cmd "startinsert!"
  end,
}

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

-- Node REPL
local node = Terminal:new { cmd = "node", hidden = true }

function _NODE_TOGGLE()
  node:toggle()
end

-- Python REPL
local python = Terminal:new { cmd = "python", hidden = true }

function _PYTHON_TOGGLE()
  python:toggle()
end

-- htop
local htop = Terminal:new { cmd = "htop", hidden = true }

function _HTOP_TOGGLE()
  htop:toggle()
end

-- Additional keymaps for convenience
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Toggle floating terminal
keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", vim.tbl_extend("force", opts, { desc = "Toggle floating terminal" }))

-- Toggle horizontal terminal
keymap("n", "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", vim.tbl_extend("force", opts, { desc = "Toggle horizontal terminal" }))

-- Toggle vertical terminal
keymap("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", vim.tbl_extend("force", opts, { desc = "Toggle vertical terminal" }))

-- Lazygit toggle
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", vim.tbl_extend("force", opts, { desc = "Toggle lazygit" }))

-- Python REPL
keymap("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", vim.tbl_extend("force", opts, { desc = "Toggle python" }))

-- Node REPL
keymap("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", vim.tbl_extend("force", opts, { desc = "Toggle node" }))

-- htop
keymap("n", "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<CR>", vim.tbl_extend("force", opts, { desc = "Toggle htop" }))
