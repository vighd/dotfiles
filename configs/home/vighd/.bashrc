shopt -s cdspell                                                        # Correct cd typos
shopt -s checkwinsize                                                   # Update windows size on command
shopt -s histappend                                                     # Append History instead of overwriting file
shopt -s cmdhist                                                        # Bash attempts to save all lines of a multiple-line command in the same history entry
shopt -s extglob                                                        # Extended pattern
shopt -s no_empty_cmd_completion                                        # No empty completion
complete -cf sudo                                                       # Bash completion with sudo
export EDITOR="vim"                                                     # Set default editor
export TERM='xterm-256color'                                            # Set default term string
export HISTSIZE=1000                                                    # bash history will save N commands
export HISTFILESIZE=${HISTSIZE}                                         # bash will remember N commands
export HISTCONTROL=ignoreboth                                           # ingore duplicates and spaces
export HISTIGNORE='&:ls:exit:clear:history'                             # Ignore commands from history
export LESS_TERMCAP_mb=$'\E[01;31m'                                     # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'                                # begin bold
export LESS_TERMCAP_me=$'\E[0m'                                         # end mode
export LESS_TERMCAP_se=$'\E[0m'                                         # end standout-mode
export LESS_TERMCAP_so=$'\E[48;5;1m\E[38;5;15m'                         # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                                         # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m'                               # begin underline
alias ls='ls --color=auto'                                              # Autocoloring ls
alias grep='grep --color=auto'                                          # Autocoloring grep
alias dmesg="dmesg --color=always"                                      # Autolocoring dmesg
alias less='bat'                                                        # Autocoloring less
alias jq="jq -C"                                                        # Autocoloring jq
alias xclip="xclip -sel clip"                                           # Set xclip default selection
alias src="cd $HOME/Digital/ecdms/src"
alias dumps="cd $HOME/Digital/ecdms/dumps"
alias startcups="sudo systemctl start org.cups.cupsd.service"
alias pacman="sudo pacman $@"
alias rm="rm -I"
alias dvpn="sudo openvpn ~/Digital/digital.ovpn"
alias fonts="fc-list : family | sort"
alias scanhosts="sudo arp-scan --interface=wlan0 --localnet"
alias dblogs="docker container logs postgres"
alias vim="nvim"
alias vimsql="nvim +DBUIToggle"
alias vimrc="cd $HOME/.config/nvim && nvim lua/globals/options.lua"
alias vimdiff="nvim -d"
alias bat="bat --theme='OneHalfDark'"
alias fonticons="xfd -fa Cozette"
alias router="ssh skulltus@192.168.50.1"
alias cat="bat --paging=never $@"
alias ip="ip -c"
export PAGER=bat                                                        # Set default pager
export BAT_THEME="Material-Theme-Palenight"
export EDITOR=nvim

## Custom functions

fd() { psql -AtU postgres -h localhost --port=5432 -d ecdms_production -c "SELECT form_data FROM forms WHERE display_id = '$1'"; }
restoredb() { DB=$2; BACKUP=$1; dropdb -U postgres -h localhost "$DB"; createdb -U postgres -h localhost "$DB"; pg_restore -U postgres -h localhost -c --if-exists -d "$DB" "$BACKUP"; }
dumpdb() { DB="$1"; OUT="$2"; pg_dump -U postgres -h localhost -Fc "$DB" > "$OUT"; }
genbootentry() { sudo efibootmgr -B -b 0 && sudo efibootmgr --create --disk /dev/sda --part 1 --label "Arch Linux" --loader /vmlinuz-linux --unicode 'root=/dev/sda3 rw initrd=\initramfs-linux.img initrd=\intel-ucode.img i915.enable_psr=0 i915.enable_dc=0 psmouse.proto=bare'; }

startdb() {
  sudo systemctl start docker
  if docker container ls -a | grep postgres > /dev/null; then
    docker container start postgres
  else
    docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=Asd..123 -e POSTGRES_HOST_AUTH_METHOD=trust --name=postgres digitalkft/ecdmsdb:latest postgres
  fi
}

stopdb() {
  docker container stop postgres
  sudo systemctl stop docker.socket
  sudo systemctl stop docker
}

dropddb() {
  docker container stop postgres
  docker container rm -v postgres
}

[[ -f "$HOME/.dircolors_256" ]] && eval "$(dircolors -b "$HOME/.dircolors_256")"

B='\[\e[1;38;5;33m\]'
LB='\[\e[1;38;5;81m\]'
GY='\[\e[1;38;5;242m\]'
P='\[\e[1;38;5;161m\]'
Y='\[\e[1;38;5;214m\]'
W='\[\e[0m\]'

[[ -f /etc/profile.d/grc.sh ]] && source /etc/profile.d/grc.sh

if [[ $PS1 && -f /usr/share/git/git-prompt.sh ]]; then
  source /usr/share/git/completion/git-completion.bash
  source /usr/share/git/git-prompt.sh
  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWUNTRACKEDFILES=0
  export PS1="$GY$Y\u$GY@$P\h$GY:$B\W\$(__git_ps1 \"$GY|$LB%s\")$GY$W "
else
  export PS1="$GY$Y\u$GY@$P\h$GY:$B\W$GY$W "
fi

export PATH="$HOME/.yarn/bin:$HOME/go/bin:$HOME/.local/bin:$PATH"
