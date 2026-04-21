{ ... }:
{
  xdg.configFile."rift/config.toml".text = ''
    [settings]
    animate = true
    animation_duration = 0.25
    animation_fps = 100.0

    default_disable = false

    focus_follows_mouse = false
    mouse_follows_focus = false
    mouse_hides_on_focus = false

    auto_focus_blacklist = []
    run_on_start = []
    hot_reload = true

    [settings.layout]
    mode = "scrolling"

    [settings.layout.scrolling]
    # niri default: 50% column width
    column_width_ratio = 0.5
    min_column_width_ratio = 0.25
    max_column_width_ratio = 1.0
    alignment = "center"
    focus_navigation_style = "niri"

    [settings.layout.scrolling.gestures]
    enabled = true
    invert_horizontal = false
    fingers = 3
    propagate_to_workspace_swipe = true

    [settings.layout.gaps.outer]
    top = 16
    left = 16
    bottom = 16
    right = 16

    [settings.layout.gaps.inner]
    horizontal = 16
    vertical = 16

    [settings.ui.menu_bar]
    enabled = true
    show_empty = false
    mode = "all"
    active_label = "index"
    display_style = "layout"

    [settings.ui.mission_control]
    enabled = false

    [settings.gestures]
    # niri uses 3-finger vertical swipe for workspaces
    enabled = true
    invert_horizontal_swipe = false
    swipe_vertical_tolerance = 0.4
    skip_empty = true
    fingers = 3
    distance_pct = 0.08
    haptics_enabled = true
    haptic_pattern = "level_change"

    [settings.window_snapping]
    drag_swap_fraction = 0.3

    [virtual_workspaces]
    enabled = true
    default_workspace_count = 4
    auto_assign_windows = true
    preserve_focus_per_workspace = true
    workspace_auto_back_and_forth = false
    reapply_app_rules_on_title_change = false

    workspace_rules = []
    workspace_names = []
    app_rules = []

    [modifier_combinations]
    # niri uses "Mod" which is Super on Linux; Alt on macOS is the closest equivalent
    mod = "Alt"
    mod-shift = "Alt + Shift"
    mod-ctrl = "Alt + Ctrl"

    [keys]
    # === Application launching (niri: Mod+T, Mod+D) ===
    # niri default is a terminal and app launcher
    "Alt + T" = { "exec" = ["/bin/bash", "-c", "open -n /Applications/Ghostty.app"] }
    "Alt + D" = { "exec" = ["/bin/bash", "-c", "open -a \"Raycast\""] }

    # === Window management (niri defaults) ===
    "Alt + Q" = { close_window = {} }

    # Exit rift (niri: Mod+Shift+E)
    "Alt + Shift + E" = "save_and_exit"

    # === Focus column left/right (niri: Mod+Left/Right, Mod+H/L) ===
    "Alt + H" = { move_focus = "left" }
    "Alt + L" = { move_focus = "right" }
    "Alt + Left" = { move_focus = "left" }
    "Alt + Right" = { move_focus = "right" }

    # === Focus window up/down within column (niri: Mod+Up/Down, Mod+K/J) ===
    "Alt + K" = { move_focus = "up" }
    "Alt + J" = { move_focus = "down" }
    "Alt + Up" = { move_focus = "up" }
    "Alt + Down" = { move_focus = "down" }

    # === Move columns left/right (niri: Mod+Ctrl+Left/Right) ===
    "Alt + Ctrl + H" = { move_node = "left" }
    "Alt + Ctrl + L" = { move_node = "right" }
    "Alt + Ctrl + Left" = { move_node = "left" }
    "Alt + Ctrl + Right" = { move_node = "right" }

    # === Move windows up/down within/between columns (niri: Mod+Ctrl+Up/Down) ===
    "Alt + Ctrl + K" = { move_node = "up" }
    "Alt + Ctrl + J" = { move_node = "down" }
    "Alt + Ctrl + Up" = { move_node = "up" }
    "Alt + Ctrl + Down" = { move_node = "down" }

    # === Consume/expel windows (niri: Mod+Comma / Mod+Period) ===
    "Alt + Comma" = { join_window = "left" }
    "Alt + Period" = "unjoin_windows"

    # === Workspaces (niri: Mod+1-9) ===
    "Alt + 1" = { switch_to_workspace = 0 }
    "Alt + 2" = { switch_to_workspace = 1 }
    "Alt + 3" = { switch_to_workspace = 2 }
    "Alt + 4" = { switch_to_workspace = 3 }

    # === Move window to workspace (niri: Mod+Shift+1-9) ===
    "Alt + Shift + 1" = { move_window_to_workspace = 0 }
    "Alt + Shift + 2" = { move_window_to_workspace = 1 }
    "Alt + Shift + 3" = { move_window_to_workspace = 2 }
    "Alt + Shift + 4" = { move_window_to_workspace = 3 }

    # === Previous workspace (niri: Mod+Tab) ===
    "Alt + Tab" = "switch_to_last_workspace"

    # === Fullscreen (niri: Mod+F) ===
    "Alt + F" = "toggle_fullscreen"

    # === Column width (niri: Mod+R cycles presets, Mod+Minus/Plus resize) ===
    # "Alt + R" = { resize_window_by = 0.0 }  # rift doesn't have preset cycling, placeholder
    "Alt + Minus" = "resize_window_shrink"
    "Alt + Equal" = "resize_window_grow"

    # === Center column (niri: Mod+C) ===
    "Alt + C" = "center_selection"

    # === Fullscreen window/column toggle in gaps (niri: Mod+Shift+F) ===
    "Alt + Shift + F" = "toggle_fullscreen_within_gaps"

    # === Floating toggle (niri: Mod+V) ===
    "Alt + V" = "toggle_window_floating"

    # === Rift-only: activate space management ===
    "Alt + Z" = "toggle_space_activated"

    # === Debug ===
    "Alt + Shift + D" = "debug"
  '';
}
