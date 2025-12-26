local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

treesitter.setup {
  ensure_installed = { "python", "cpp", "lua", "vim", "json", "toml", "bash", "markdown", "markdown_inline" },
  ignore_install = {}, -- List of parsers to ignore installing
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  -- Treesitter textobjects configuration
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      selection_modes = {
        ["@function.inner"] = "V", -- linewise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = "V", -- linewise
        ["@class.inner"] = "V", -- linewise
        ["@parameter.outer"] = "v", -- charwise
      },
      include_surrounding_whitespace = false,
    },
  },
}
