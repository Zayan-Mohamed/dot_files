local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Performance and GPU settings
config.front_end = "WebGpu"
config.max_fps = 120
config.animation_fps = 60
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.font = wezterm.font( "Jetbrains Mono", { weight = "Regular" })
config.font_size = 12
config.use_dead_keys = false
config.line_height = 1.5
config.window_padding = {
        left = 14,
        right = 14,
        top = 14,
        bottom = 14,
}

config.window_frame = {
        font = wezterm.font { family = 'Roboto', weight = 'Bold' },
        active_titlebar_bg = '#333333',
        inactive_titlebar_bg = '#333333',
}

config.colors = {
  tab_bar = {
    inactive_tab_edge = '#575757',
  },
}

config.window_background_image = '/home/zayan/Pictures/wall2.jpeg'
config.window_background_image_hsb = {
  brightness = 0.05,  -- Very dim background for better text visibility
}
config.window_background_opacity = 0.95
config.tab_bar_at_bottom = false
config.scrollback_lines = 100000
config.tab_max_width = 16
config.text_blink_rate = 500
config.cursor_blink_rate = 400
config.default_cursor_style = "BlinkingBlock"

-- Scrolling and visual enhancements
config.enable_scroll_bar = false
config.min_scroll_bar_height = "2cell"
config.enable_kitty_graphics = true
config.enable_kitty_keyboard = true
config.adjust_window_size_when_changing_font_size = false
config.keys = {
        -- Original keybindings
        { key = "p", mods = "CMD", action = act.SendKey({ key = "p", mods = "CTRL" }) },
        { key = "n", mods = "CMD", action = act.SendKey({ key = "n", mods = "CTRL" }) },
        { key = "LeftArrow", mods = "OPT", action = act.SendKey({ key = "b", mods = "ALT" }) },
        { key = "RightArrow", mods = "OPT", action = act.SendKey({ key = "f", mods = "ALT" }) },
        
        -- Pane splitting
        { key = "d", mods = "CMD", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
        { key = "d", mods = "CMD|SHIFT", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
        
        -- Pane navigation
        { key = "h", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Left") },
        { key = "l", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Right") },
        { key = "k", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Up") },
        { key = "j", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Down") },
        
        -- Close pane
        { key = "w", mods = "CMD", action = act.CloseCurrentPane { confirm = true } },
        
        -- Tab navigation
        { key = "{", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
        { key = "}", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
        { key = "t", mods = "CMD", action = act.SpawnTab "CurrentPaneDomain" },
        
        -- Font size
        { key = "=", mods = "CMD", action = act.IncreaseFontSize },
        { key = "-", mods = "CMD", action = act.DecreaseFontSize },
        { key = "0", mods = "CMD", action = act.ResetFontSize },
        
        -- Copy mode
        { key = "f", mods = "CMD|SHIFT", action = act.Search "CurrentSelectionOrEmptyString" },
        { key = "c", mods = "CMD|SHIFT", action = act.ActivateCopyMode },
}

config.window_decorations = "NONE"
config.enable_tab_bar = false

-- Mouse bindings
config.mouse_bindings = {
  -- CTRL+scroll to zoom
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = "CTRL",
    action = act.IncreaseFontSize,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = "CTRL",
    action = act.DecreaseFontSize,
  },
  -- Change selection behavior to copy to clipboard
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection "Clipboard",
  },
}

-- Hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- Make URLs with custom schemes clickable
table.insert(config.hyperlink_rules, {
  regex = [[['"]?(file://\S*)['"]?]],
  format = "$1",
})

function scheme_for_appearance(appearance)
        if appearance:find("Dark") then
                return "Atelierdune (dark) (terminal.sexy)"
        else
                return "Atelierdune (light) (terminal.sexy)"
        end
end

wezterm.on("window-config-reloaded", function(window, pane)
        local overrides = window:get_config_overrides() or {}
        local appearance = window:get_appearance()
        local scheme = scheme_for_appearance(appearance)
        if overrides.color_scheme ~= scheme then
                overrides.color_scheme = scheme
                window:set_config_overrides(overrides)
        end
end)

wezterm.on("update-right-status", function(window, pane)
        -- "Wed Mar 3 08:14"
        local date = wezterm.strftime("%a %b %-d %H:%M:%S ")

        local bat = ""
        for _, b in ipairs(wezterm.battery_info()) do
                bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
        end

        window:set_right_status(wezterm.format({
                { Text = bat .. "   " .. date },
        }))
end)
config.initial_rows = 50
config.initial_cols = 250
config.force_reverse_video_cursor = true

return config
