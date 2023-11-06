#
# ~/.bash_profile
#

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec dbus-run-session river > ~/.river.log 2>&1
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
