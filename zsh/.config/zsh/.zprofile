#
# .zprofile
#
# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Session-wide environment variables
export BROWSER="brave"
export EDITOR="nvim"
export VISUAL="nvim"
export LESSHISTFILE=-
export GIT_CONFIG_GLOBAL="$HOME/.config/git/.gitconfig"
export XCURSOR_SIZE=16
export LIBVIRT_DEFAULT_URI="qemu:///system"
export GOPATH="$HOME/dev/go"
export PATH="$HOME/dev/go/bin:$PATH"
export MANPAGER="nvim +Man!"
export MANROFFOPT="-c"

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
