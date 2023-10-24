#
# ~/.bash_profile
#

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
