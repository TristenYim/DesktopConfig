

# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILE="$HOME/.command_history"
HISTFILESIZE=100000
HISTSIZE=10000

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
  . "/etc/profile.d/bash_completion.sh"
fi

if [[ $TERM != "dumb" ]]; then
  eval "$(starship init bash)"
fi

if test -n "$KITTY_INSTALLATION_DIR"; then
  export KITTY_SHELL_INTEGRATION="no-rc"
  source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi

