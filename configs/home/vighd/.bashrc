# ============================================================================
# Shell Options
# ============================================================================
shopt -s cdspell                   # Correct minor typos in directory names
shopt -s checkwinsize              # Update LINES and COLUMNS after each command
shopt -s histappend                # Append history instead of overwriting
shopt -s cmdhist                   # Save multi-line commands as single history entry
shopt -s extglob                   # Enable extended pattern matching
shopt -s no_empty_cmd_completion   # Don't complete empty command lines

# ============================================================================
# Core Configuration
# ============================================================================
complete -cf sudo                  # Enable completion for sudo
export EDITOR=nvim
export PAGER=bat

# ============================================================================
# History Configuration
# ============================================================================
export HISTSIZE=20000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth      # Ignore duplicate and space-prefixed commands
export HISTIGNORE='&:ls:exit:clear:history'

# ============================================================================
# Color Scheme for Less Pager
# ============================================================================
export LESS_TERMCAP_mb=$'\E[01;31m'           # Blinking text
export LESS_TERMCAP_md=$'\E[01;38;5;74m'      # Bold text
export LESS_TERMCAP_me=$'\E[0m'               # End special mode
export LESS_TERMCAP_se=$'\E[0m'               # End standout mode
export LESS_TERMCAP_so=$'\E[48;5;1m\E[38;5;15m'  # Begin standout mode (info box)
export LESS_TERMCAP_ue=$'\E[0m'               # End underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m'     # Begin underline

# ============================================================================
# Aliases - CLI Enhancements
# ============================================================================
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'
alias jq='jq -C'
alias cat='bat --paging=never'
alias ip='ip -c'
alias vim='nvim'
alias vimdiff='nvim -d'
alias rm='rm -I'

# ============================================================================
# Aliases - Navigation
# ============================================================================
alias src="cd $HOME/Digital/src"
alias dumps="cd $HOME/Digital/ecdms/dumps"
alias vimrc="cd $HOME/.config/nvim && nvim lua/config/options.lua"

# ============================================================================
# Aliases - Applications & Tools
# ============================================================================
alias startcups="sudo systemctl start org.cups.cupsd.service"
alias pacman="sudo pacman $@"
alias dvpn="sudo openvpn ~/Digital/vpn/digital.ovpn"
alias fonts="fc-list : family | sort"
alias scanhosts="sudo arp-scan --interface=wlan0 --localnet"
alias vimsql="nvim +DBUIToggle"
alias river="dbus-run-session river > .river.log 2>&1"
alias rivercfg="vim .config/river/init"

# ============================================================================
# Aliases - Connections
# ============================================================================

# ============================================================================
# Database Functions
# ============================================================================

# Restore PostgreSQL database from backup
restoredb() {
  DB=$2
  BACKUP=$1
  dropdb -U postgres -h localhost "$DB"
  createdb -U postgres -h localhost "$DB"
  pg_restore -U postgres -h localhost -c --if-exists -d "$DB" "$BACKUP"
}

# Dump PostgreSQL database to file
dumpdb() {
  DB="$1"
  OUT="$2"
  pg_dump -U postgres -h localhost -Fc "$DB" > "$OUT"
}

# Start PostgreSQL database container (custom ECDMS image)
startdb() {
  sudo systemctl start docker
  if docker container ls -a | grep postgres > /dev/null; then
    docker container start postgres
  else
    docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=Asd..123 \
      -e POSTGRES_HOST_AUTH_METHOD=trust --name=postgres \
      digitalkft/ecdmsdb:latest postgres
  fi
}

# Start PostgreSQL database container (Alpine image)
startlatestdb() {
  sudo systemctl start docker
  if docker container ls -a | grep postgres > /dev/null; then
    docker container start postgres
  else
    docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=Asd..123 \
      -e POSTGRES_HOST_AUTH_METHOD=trust --name=postgres \
      postgres:15-alpine postgres
  fi
}

# ============================================================================
# External Configuration Files
# ============================================================================
[[ -f "$HOME/.catppuccin-frappe-prompt.sh" ]] && source ~/.catppuccin-frappe-prompt.sh
[[ -f "$HOME/.dircolors_256" ]] && eval "$(dircolors -b "$HOME/.dircolors_256")"
[[ -f /etc/profile.d/grc.sh ]] && source /etc/profile.d/grc.sh
[[ -f "$HOME/.local/bin/mise" ]] && eval "$(~/.local/bin/mise activate bash)"
[[ -f "/usr/share/nvm/init-nvm.sh" ]] && source "/usr/share/nvm/init-nvm.sh"

# ============================================================================
# Node Version Manager (Lazy Loading)
# ============================================================================
#nvm() {
#  unset -f nvm node npm npx pnpm yarn
#  export NVM_DIR="$HOME/.nvm"
#  [ -s "/usr/share/nvm/nvm.sh" ] && source "/usr/share/nvm/nvm.sh"
#  [ -s "/usr/share/nvm/bash_completion" ] && source "/usr/share/nvm/bash_completion"
#  nvm "$@"
#}

# ============================================================================
# PATH Configuration
# ============================================================================
export PATH="$HOME/.yarn/bin:$HOME/go/bin:$HOME/.local/bin:$HOME/.local/share/pnpm/:$PATH"

# pnpm
export PNPM_HOME="/home/vighd/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
