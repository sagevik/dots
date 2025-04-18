# --- Colors ---

# kanagawa colors
dragonBlack0="#0d0c0c"
dragonBlack1="#12120f"
dragonBlack2="#1D1C19"
dragonBlack3="#181616"
dragonBlack4="#282727"
dragonBlack5="#393836"
dragonBlack6="#625e5a"

dragonWhite="#c5c9c5"
dragonGreen="#87a987"
dragonGreen2="#8a9a7b"
dragonPink="#a292a3"
dragonOrange="#b6927b"
dragonOrange2="#b98d7b"
dragonGray="#a6a69c"
dragonGray2="#9e9b93"
dragonGray3="#7a8382"
dragonBlue2="#8ba4b0"
dragonViolet=" #8992a7"
dragonRed="#c4746e"
dragonAqua="#8ea4a2"
dragonAsh="#737c73"
dragonTeal="#949fb5"
dragonYellow="#c4b28a"

# ----------> Exports <---------- #
export BROWSER="brave"
export EDITOR="nvim"
export VISUAL="nvim"
export LESSHISTFILE=-
export GIT_CONFIG_GLOBAL="$HOME/.config/git/.gitconfig"

export XCURSOR_SIZE=16
export LIBVIRT_DEFAULT_URI=qemu:///system
export GOPATH="$HOME/dev/go"
export PATH="$HOME/dev/go/bin:$PATH"

export MANPAGER="nvim +Man!"
#export MANPAGER="less --RAW-CONTROL-CHARS --use-color --color=d+g --color=u+y"
export MANROFFOPT="-c"

# Basic auto/tab complete:
autoload -Uz compinit
setopt PROMPT_SUBST
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-Z}'
zstyle ':completion:*' menu select

zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

# ----------> Aliases <---------- #
alias reload="source $HOME/.config/zsh/.zshrc"
alias sctl="sudo systemctl"

# cd
alias ..="cd .."

# ls
alias ls="ls --color=auto"
alias ll="ls -l --color=auto"
alias la="ls -a --color=auto"
alias lla="ls -la --color=auto"

# Git
alias ga="git add"
alias gst="git status"
alias gc="git commit"
alias gb="git branch"
alias gp="git push"
alias gls="git ls-files"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias grv="git remote -v"

# Vim
alias v="nvim"

# tmux
alias t="tmux new-session -A -s _x_"
alias tmls="tmux ls"
alias tmcheat="nvim -O $HOME/.config/tmux/tmux-cht-languages $HOME/.config/tmux/tmux-cht-command"

# Edit configs
alias zshrc="nvim ~/.config/zsh/.zshrc"
alias xinitrc="nvim ~/.xinitrc"
alias vimrc="nvim ~/.config/vim/.vimrc"
alias nviminit="nvim ~/.config/nvim/init.lua"
alias tmuxconf="nvim ~/.config/tmux/tmux.conf"
alias riverconf="nvim ~/.config/river/init"

# Jotta
alias jc="jotta-cli"
alias jcs="jotta-cli status"
alias jco="jotta-cli observe"
alias jcls="jotta-cli ls Backup/$HOSTNAME"

# ----------> Functions <---------- #

# ----------> Yazi <---------- #

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#cd() {
#    [[ $# -eq 0 ]] && return
#    builtin cd "$@"
#}

fzfcd() {
#    cd $1
    if [ -z $1 ]
    then
        selection="$(fzf --reverse --border)"
        if [[ -d "$selection" ]]
        then
            cd "$selection"
        elif [[ -f "$selection" ]]
        then
            cd "$(dirname $selection)"
        fi
    fi
}
alias f=fzfcd

# ----------> Archive Extract <---------- #

ex () {
    if [ -f "$1" ] ; then
        # Extract base name without extension for folder creation
        folder_name="${1%.*}"

        # Create the folder and extract into it
        mkdir -p "$folder_name" && cd "$folder_name"

        case "$1" in
            *.tar.bz2)   tar xjf "../$1"   ;;
            *.tar.gz)    tar xzf "../$1"   ;;
            *.bz2)       bunzip2 "../$1"   ;;
            *.rar)       unrar x "../$1"   ;;
            *.gz)        gunzip "../$1"    ;;
            *.tar)       tar xvf "../$1"   ;;
            *.tbz2)      tar xjf "../$1"   ;;
            *.tgz)       tar xzvf "../$1"  ;;
            *.zip)       unzip "../$1"     ;;
            *.Z)         uncompress "../$1";;
            *.7z)        7za e "../$1"     ;;
            *.deb)       ar x "../$1"      ;;
            *.tar.xz)    tar xf "../$1"    ;;
            *.tar.zst)   unzstd "../$1"    ;;
            *)           echo "'$1' cannot be extracted via ex()" && cd .. && rmdir "$folder_name" ;;
        esac
        cd ..
    else
        echo "'$1' is not a valid file"
    fi
}

# ----------> Prompt <---------- #
parse_git_dirty() {
  STATUS="$(git status 2> /dev/null)"
  if [[ $? -ne 0 ]]; then printf ""; return; else printf " ["; fi
  if echo ${STATUS} | grep -c "renamed:"         &> /dev/null; then printf " >"; else printf ""; fi
  if echo ${STATUS} | grep -c "branch is ahead:" &> /dev/null; then printf " !"; else printf ""; fi
  if echo ${STATUS} | grep -c "new file::"       &> /dev/null; then printf " +"; else printf ""; fi
  if echo ${STATUS} | grep -c "Untracked files:" &> /dev/null; then printf " ?"; else printf ""; fi
  if echo ${STATUS} | grep -c "modified:"        &> /dev/null; then printf " *"; else printf ""; fi
  if echo ${STATUS} | grep -c "deleted:"         &> /dev/null; then printf " -"; else printf ""; fi
  printf " ]"
}

parse_git_branch() {
  # Long form
  git rev-parse --abbrev-ref HEAD 2> /dev/null
 # Short form
  # git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/.*\/\(.*\)/\1/'
}

git_status() {
    BRANCH=$(parse_git_branch)
    if [[ $? -ne 0 ]]
    then
        echo ""
	return
    else
        echo "%B%F{$dragonAsh}($(parse_git_branch)$(parse_git_dirty)) "
    fi
}

PROMPT='%B%F{$dragonBlue2}  %B%F{$dragonGreen}%~ $(git_status)%B%F{$dragonBlue2} %b%F{$dragonWhite}'
# RPROMPT='%b%F{$dragonWhite}%T'
# PROMPT="%B%F{$dragonRed}[%F{$dragonYellow}%n%F{$dragonGreen}@%F{$dragonBlue2}%M %F{$dragonPink}%~%F{i$dragonRed}]%F{$dragonGreen}$(git_status)$%{$reset_color%}%b "

# Enable history appending and sharing
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# History in cache directory:
HISTFILE=~/.cache/zsh/history

fh() {
    # Determine mode and set fzf prompt
    if [[ "$1" == "e" ]]; then
        mode="Execute"
        fzf_prompt="Execute > "
    else
        mode="Copy"
        fzf_prompt="Copy > "
    fi

    clear
    cmd=$(history 1 | fzf --reverse --height 100% --border --tac +s --prompt="$fzf_prompt")
    cmd=$(echo "$cmd" | sed 's/ *[0-9]\+\*\{0,1\} *//')

    [[ -z "$cmd" ]] && return 0

    echo "--> cmd: $cmd <--"

    # Handle mode: copy or execute
    if [[ "$mode" == "Execute" ]]; then
        # Execute the command
        eval "$cmd"
    else
        # echo -n "$cmd" | wl-copy  # For Wayland
        echo -n "$cmd" | xclip -selection clipboard  # Uncomment for X11
        echo "Command copied to clipboard!"
    fi
}

# alias for execute from history
alias fhe="fh e"

# Load zsh plugins
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always {}'"

# zoxide
eval "$(zoxide init zsh)"


[ -f "/home/rs/.ghcup/env" ] && . "/home/rs/.ghcup/env" # ghcup-env
