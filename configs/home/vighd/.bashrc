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
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"                  # Colorize less source, this function needs the source-highlight package
alias headset="bluetoothctl connect FC:58:FA:51:D2:84"                  # Headset connection alias
alias ls='ls --color=auto'                                              # Autocoloring ls
alias grep='grep --color=auto'                                          # Autocoloring grep
alias dmesg="dmesg --color=always"                                      # Autolocoring dmesg
alias less='less -R'                                                    # Autocoloring less
alias jq="jq -C"                                                        # Autocoloring jq
alias xclip="xclip -sel clip"                                           # Set xclip default selection
alias src="cd $HOME/Digital/ecdms/src"
alias migr="cd $HOME/Digital/ecdms/src/ap-data-migration"
alias dumps="cd $HOME/Digital/ecdms/dumps"
alias vimrc="vim $HOME/.vimrc"
alias vimreinstall="rm -rf $HOME/.vim && vim +PlugInstall +qall && vim"
alias startcups="sudo systemctl start org.cups.cupsd.service"
alias pacman="sudo pacman $@"
alias start="sudo systemctl start $@"
alias stop="sudo systemctl stop $@"
alias rm="rm -I"
alias powersave="sudo cpupower frequency-set -g powersave"
alias performance="sudo cpupower frequency-set -g performance"
export PAGER=less                                                       # Set default pager

## Custom functions

fd() { psql -AtU postgres -c "SELECT form_data FROM forms WHERE display_id = '$1'" ecdms_production | jq . | less; }
restoredb() { DB=$2; BACKUP=$1; dropdb -U postgres "$DB"; createdb -U postgres "$DB"; pg_restore -U postgres -c --if-exists -d "$DB" "$BACKUP"; }
dumpdb() { DB="$1"; OUT="$2"; pg_dump -U postgres -Fc "$DB" > "$OUT"; }
genbootentry() { efibootmgr --disk /dev/sda --part 1 --create --label "Arch Linux Zen" --loader /vmlinuz-linux-zen --unicode 'root=PARTUUID=844a07de-a4e5-c447-9cb9-8bcb92b57d79 rw initrd=\intel-ucode.img initrd=\initramfs-linux-zen.img' --verbose;  }

[[ -f "$HOME/.dircolors_256" ]] && eval "$(dircolors -b "$HOME/.dircolors_256")"

B='\[\e[1;38;5;33m\]'
LB='\[\e[1;38;5;81m\]'
GY='\[\e[1;38;5;242m\]'
P='\[\e[1;38;5;161m\]'
Y='\[\e[1;38;5;214m\]'
W='\[\e[0m\]'

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

source /etc/profile.d/vte.sh
export PATH="$HOME/.yarn/bin:$HOME/go/bin:$PATH"
