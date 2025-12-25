local utils = require("utils")

------------------------------------------------------------------------
--                          custom variables                          --
------------------------------------------------------------------------
vim.g.is_win = (utils.has("win32") or utils.has("win64")) and true or false
vim.g.is_linux = (utils.has("unix") and (not utils.has("macunix"))) and true or false
vim.g.is_mac = utils.has("macunix") and true or false

vim.g.logging_level = vim.log.levels.INFO

------------------------------------------------------------------------
--                         builtin variables                          --
------------------------------------------------------------------------
vim.g.loaded_perl_provider = 0 -- Disable perl provider
vim.g.loaded_ruby_provider = 0 -- Disable ruby provider
vim.g.loaded_node_provider = 0 -- Disable node provider

-- Set Python3 provider (required for UltiSnips and other Python plugins)
-- Dynamically find Python3 with pynvim installed, avoiding virtual environments
local function find_python3_host()
  -- Try system Python locations first (avoid venv/virtualenv)
  local python_candidates = {
    '/usr/bin/python3',
    '/usr/local/bin/python3',
    vim.fn.expand('~/miniconda3/bin/python3'),
    vim.fn.expand('~/.pyenv/shims/python3'),
  }
  
  -- Check each candidate
  for _, python_path in ipairs(python_candidates) do
    if vim.fn.executable(python_path) == 1 then
      -- Verify pynvim is installed
      local handle = io.popen(python_path .. ' -c "import pynvim" 2>&1')
      if handle then
        local result = handle:read("*a")
        handle:close()
        if result == "" then
          return python_path
        end
      end
    end
  end
  
  -- Fallback: try to find any python3 in PATH (excluding venv)
  local python_in_path = vim.fn.exepath('python3')
  if python_in_path ~= "" and not python_in_path:match('/venv/') and not python_in_path:match('/virtualenv/') then
    return python_in_path
  end
  
  return nil
end

vim.g.python3_host_prog = find_python3_host()

vim.g.did_install_default_menus = 1 -- do not load menu

-- Custom mapping <leader> (see `:h mapleader` for more info)
vim.g.mapleader = ","

-- Enable highlighting for lua HERE doc inside vim script
vim.g.vimsyn_embed = "l"

-- Use English as main language
vim.cmd([[language en_US.UTF-8]])

-- Disable loading certain plugins

-- Whether to load netrw by default, see https://github.com/bling/dotvim/issues/4
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 3
if vim.g.is_win then
  vim.g.netrw_http_cmd = "curl --ssl-no-revoke -Lo"
end

-- Do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

-- Do not load the tutor plugin
vim.g.loaded_tutor_mode_plugin = 1

-- Do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1

-- control how to show health check window
vim.g.health = { style = nil }
