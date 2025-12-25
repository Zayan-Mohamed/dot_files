local auto_save = require("auto-save")

auto_save.setup({
  -- Enable auto-save
  enabled = true,

  -- Trigger events that will start auto-save
  trigger_events = {
    immediate_save = { "BufLeave", "FocusLost" }, -- Save immediately on these events
    defer_save = { "InsertLeave", "TextChanged" }, -- Save after `debounce_delay` on these events
    cancel_deferred_save = { "InsertEnter" }, -- Cancel pending saves on these events
  },

  -- Conditions to evaluate before saving
  condition = function(buf)
    local fn = vim.fn
    local utils = require("auto-save.utils.data")

    -- Don't save for special filetypes
    if utils.not_in(fn.getbufvar(buf, "&filetype"), { "oil", "dashboard", "alpha", "TelescopePrompt" }) then
      return true
    end
    return false
  end,

  -- Write all buffers before saving
  write_all_buffers = false,

  -- Don't execute autocmds when saving
  noautocmd = false,

  -- Delay in milliseconds before saving after defer_save events
  debounce_delay = 1000, -- 1 second

  -- Log debug messages
  debug = false,

  -- Function to run before saving
  callbacks = {
    enabling = nil,
    disabling = nil,
    before_asserting_save = nil,
    before_saving = nil,
    after_saving = function()
      -- Optional: Show a message when file is auto-saved (can be commented out if annoying)
      -- vim.notify("File auto-saved", vim.log.levels.INFO, { title = "Auto-Save" })
    end,
  },
})
