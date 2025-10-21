#!/bin/bash
# Catppuccin Frappé PS1 prompt with git support and OSC7 CWD support

# Catppuccin Frappé colors
FRAPPE_ROSEWATER="\[\e[38;2;242;213;207m\]"
FRAPPE_FLAMINGO="\[\e[38;2;238;190;190m\]"
FRAPPE_PINK="\[\e[38;2;244;184;228m\]"
FRAPPE_MAUVE="\[\e[38;2;202;158;230m\]"
FRAPPE_RED="\[\e[38;2;231;130;132m\]"
FRAPPE_MAROON="\[\e[38;2;234;153;156m\]"
FRAPPE_PEACH="\[\e[38;2;239;159;118m\]"
FRAPPE_YELLOW="\[\e[38;2;229;200;144m\]"
FRAPPE_GREEN="\[\e[38;2;166;209;137m\]"
FRAPPE_TEAL="\[\e[38;2;129;200;190m\]"
FRAPPE_SKY="\[\e[38;2;153;209;219m\]"
FRAPPE_SAPPHIRE="\[\e[38;2;133;193;220m\]"
FRAPPE_BLUE="\[\e[38;2;140;170;238m\]"
FRAPPE_LAVENDER="\[\e[38;2;186;187;241m\]"
FRAPPE_TEXT="\[\e[38;2;198;208;245m\]"
FRAPPE_SUBTEXT1="\[\e[38;2;181;191;226m\]"
FRAPPE_SUBTEXT0="\[\e[38;2;165;173;206m\]"
FRAPPE_OVERLAY2="\[\e[38;2;147;154;183m\]"
FRAPPE_OVERLAY1="\[\e[38;2;131;139;167m\]"
FRAPPE_OVERLAY0="\[\e[38;2;115;121;148m\]"
FRAPPE_SURFACE2="\[\e[38;2;98;104;128m\]"
FRAPPE_SURFACE1="\[\e[38;2;81;87;109m\]"
FRAPPE_SURFACE0="\[\e[38;2;65;69;89m\]"
FRAPPE_BASE="\[\e[38;2;48;52;70m\]"
FRAPPE_MANTLE="\[\e[38;2;41;44;60m\]"
FRAPPE_CRUST="\[\e[38;2;35;38;52m\]"

# Style attributes
BOLD="\[\e[1m\]"
RESET="\[\e[0m\]"

# Git functions
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

parse_git_status() {
    local status=$(git status --porcelain 2> /dev/null)
    
    if [[ -z "$status" ]]; then
        echo "clean"
    else
        echo "dirty"
    fi
}

# Function to update the OSC7 working directory
update_osc7_cwd() {
    # Get the current working directory
    local pwd_uri="file://$HOSTNAME${PWD}"
    
    # Send the OSC7 escape sequence
    printf "\e]7;%s\a" "$pwd_uri"
}

# Function to set the PS1 prompt
set_ps1() {
    # Update the OSC7 CWD first
    update_osc7_cwd
    
    # Get the exit code of the last command
    local exit_code=$?
    local exit_status=""
    
    # Add exit code indicator if non-zero AND not 130 (Ctrl+C)
    if [ $exit_code -ne 0 ] && [ $exit_code -ne 130 ]; then
        exit_status="${FRAPPE_RED}✗ $exit_code ${RESET}"
    fi
    
    # Basic prompt parts with bold username and hostname
    local user_host="${FRAPPE_LAVENDER}${BOLD}\u${RESET}${FRAPPE_SURFACE2}@${FRAPPE_BLUE}${BOLD}\h${RESET}"
    local current_dir="${FRAPPE_SAPPHIRE}\w${RESET}"
    local prompt_char="${FRAPPE_GREEN}❯${RESET}"
    
    # Git part
    local git_info=""
    local git_branch=$(parse_git_branch)
    
    if [ ! -z "$git_branch" ]; then
        local git_status=$(parse_git_status)
        local branch_color="${FRAPPE_MAUVE}"
        local status_indicator=""
        
        if [ "$git_status" == "dirty" ]; then
            status_indicator=" ${FRAPPE_PEACH}✱${RESET}"
        else
            status_indicator=" ${FRAPPE_GREEN}✓${RESET}"
        fi
        
        git_info="${FRAPPE_SURFACE2} on ${branch_color}󰘬 ${git_branch}${status_indicator}${RESET}"
    fi
    
    # Time part
    local time_part="${FRAPPE_SURFACE2}[${FRAPPE_YELLOW}\t${FRAPPE_SURFACE2}]${RESET}"
    
    # Set the PS1 variable
    PS1="${exit_status}${time_part} ${user_host} ${current_dir}${git_info}\n${prompt_char} "
}

# Set the PROMPT_COMMAND to call set_ps1
PROMPT_COMMAND=set_ps1
