#!/usr/bin/env zsh
# Prompt Theme Switcher for Starship and Powerlevel10k
# Usage: 
#   toggle          - Switch between themes
#   toggle starship - Set to Starship
#   toggle p10k     - Set to Powerlevel10k

PROMPT_STATE_FILE="$HOME/.config/prompt_theme"

# Initialize state file if it doesn't exist
if [[ ! -f "$PROMPT_STATE_FILE" ]]; then
    echo "p10k" > "$PROMPT_STATE_FILE"
fi

toggle() {
    local current_theme=$(cat "$PROMPT_STATE_FILE" 2>/dev/null || echo "p10k")
    local new_theme=""
    
    # If argument provided, use it; otherwise toggle
    if [[ -n "$1" ]]; then
        case "$1" in
            starship|star|s)
                new_theme="starship"
                ;;
            p10k|powerlevel10k|power|p)
                new_theme="p10k"
                ;;
            *)
                echo "Unknown theme: $1"
                echo "Available themes: starship, p10k"
                return 1
                ;;
        esac
    else
        # Toggle between themes
        if [[ "$current_theme" == "starship" ]]; then
            new_theme="p10k"
        else
            new_theme="starship"
        fi
    fi
    
    # Save the new theme
    echo "$new_theme" > "$PROMPT_STATE_FILE"
    
    # Provide feedback
    if [[ "$new_theme" == "starship" ]]; then
        echo "Switched to Starship prompt"
        echo "Restart your terminal or run: exec zsh"
    else
        echo "Switched to Powerlevel10k prompt"
        echo "Restart your terminal or run: exec zsh"
    fi
}

# Function to check current prompt
check-prompt() {
    local current=$(cat "$PROMPT_STATE_FILE" 2>/dev/null || echo "p10k")
    if [[ "$current" == "starship" ]]; then
        echo "Current prompt: Starship"
    else
        echo "Current prompt: Powerlevel10k"
    fi
}
