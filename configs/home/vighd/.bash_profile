#
# ~/.bash_profile
#

export EDITOR="nvim"

# Only start the session if the shell is INTERACTIVE and we are on TTY1
if [[ $- == *i* ]] && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && [ -z "${SSH_CONNECTION}" ]; then
    # Ensure a Wayland session is not already running
    if [ -z "${WAYLAND_DISPLAY}" ]; then
        exec dbus-run-session river > ~/.river.log 2>&1
    fi
fi

# Load .bashrc for all shell instances
[[ -f ~/.bashrc ]] && . ~/.bashrc
