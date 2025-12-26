local api = vim.api
local keymap = vim.keymap
local dashboard = require("dashboard")

local conf = {}
-- conf.header = {
--   "                                                       ",
--   "                                                       ",
--   "                                                       ",
--   " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
--   " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
--   " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
--   " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
--   " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
--   " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
--   "                                                       ",
--   "                                                       ",
--   "                                                       ",
--   "                                                       ",
-- }

conf.header = {
  "                                                                                                                                ",
  "ZZZZZZZZZZZZZZZZZZZ                                                                              MMMMMMMM               MMMMMMMM",
  "Z:::::::::::::::::Z                                                                              M:::::::M             M:::::::M",
  "Z:::::::::::::::::Z                                                                              M::::::::M           M::::::::M",
  "Z:::ZZZZZZZZ:::::Z                                                                               M:::::::::M         M:::::::::M",
  "ZZZZZ     Z:::::Z     aaaaaaaaaaaaa yyyyyyy           yyyyyyy aaaaaaaaaaaaa   nnnn  nnnnnnnn     M::::::::::M       M::::::::::M",
  "        Z:::::Z       a::::::::::::a y:::::y         y:::::y  a::::::::::::a  n:::nn::::::::nn   M:::::::::::M     M:::::::::::M",
  "       Z:::::Z        aaaaaaaaa:::::a y:::::y       y:::::y   aaaaaaaaa:::::a n::::::::::::::nn  M:::::::M::::M   M::::M:::::::M",
  "      Z:::::Z                  a::::a  y:::::y     y:::::y             a::::a nn:::::::::::::::n M::::::M M::::M M::::M M::::::M",
  "     Z:::::Z            aaaaaaa:::::a   y:::::y   y:::::y       aaaaaaa:::::a   n:::::nnnn:::::n M::::::M  M::::M::::M  M::::::M",
  "    Z:::::Z           aa::::::::::::a    y:::::y y:::::y      aa::::::::::::a   n::::n    n::::n M::::::M   M:::::::M   M::::::M",
  "   Z:::::Z           a::::aaaa::::::a     y:::::y:::::y      a::::aaaa::::::a   n::::n    n::::n M::::::M    M:::::M    M::::::M",
  "ZZZ:::::Z     ZZZZZ a::::a    a:::::a      y:::::::::y      a::::a    a:::::a   n::::n    n::::n M::::::M     MMMMM     M::::::M",
  "Z::::::ZZZZZZZZ:::Z a::::a    a:::::a       y:::::::y       a::::a    a:::::a   n::::n    n::::n M::::::M               M::::::M",
  "Z:::::::::::::::::Z a:::::aaaa::::::a        y:::::y        a:::::aaaa::::::a   n::::n    n::::n M::::::M               M::::::M",
  "Z:::::::::::::::::Z  a::::::::::aa:::a      y:::::y          a::::::::::aa:::a  n::::n    n::::n M::::::M               M::::::M",
  "ZZZZZZZZZZZZZZZZZZZ   aaaaaaaaaa  aaaa     y:::::y            aaaaaaaaaa  aaaa  nnnnnn    nnnnnn MMMMMMMM               MMMMMMMM",
  "                                          y:::::y                                                                               ",
  "                                         y:::::y                                                                                ",
  "                                        y:::::y                                                                                 ",
  "                                       y:::::y                                                                                  ",
  "                                      yyyyyyy                                                                                   ",
  "                                                                                                                                ",
}

conf.center = {
  {
    icon = "󰈞  ",
    desc = "Find  File                              ",
    action = "FzfLua files",
    key = "<Leader> f f",
  },
  {
    icon = "󰈢  ",
    desc = "Recently opened files                   ",
    action = "FzfLua oldfiles",
    key = "<Leader> f r",
  },
  {
    icon = "󰈬  ",
    desc = "Project grep                            ",
    action = "FzfLua live_grep",
    key = "<Leader> f g",
  },
  {
    icon = "  ",
    desc = "Open Nvim config                        ",
    action = "tabnew $MYVIMRC | tcd %:p:h",
    key = "<Leader> e v",
  },
  {
    icon = "  ",
    desc = "New file                                ",
    action = "enew",
    key = "e",
  },
  {
    icon = "󰗼  ",
    desc = "Quit Nvim                               ",
    -- desc = "Quit Nvim                               ",
    action = "qa",
    key = "q",
  },
}

dashboard.setup {
  theme = "doom",
  shortcut_type = "number",
  config = conf,
}

api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
  callback = function()
    keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
    keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
  end,
})
