#
# .zprofile
#
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
