# --- Colors ---
[[ -f ~/.config/zsh/colors.zsh ]] && source ~/.config/zsh/colors.zsh

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$PATH:/$HOME/scripts"
# export PATH="$PATH:/usr/local/go/bin"

# Basic auto/tab complete:
autoload -Uz compinit
setopt PROMPT_SUBST
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-Z}'
zstyle ':completion:*' menu select

zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v

# ----------> Aliases <---------- #
alias reload="source $HOME/.config/zsh/.zshrc"
alias sctl="sudo systemctl"

# cd
alias ..="cd .."

# ls
# alias ls="ls --color=auto"
alias ls="eza --icons=never --color=always"
alias ll="ls -l"
alias la="ls -a"
alias lc="ls | wc -l"
alias lla="ls -la"

# Git
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias gls="git ls-files"
alias gp="git push"
alias grv="git remote -v"
alias gst="git status"

# Zathura pdf
function pdf() {
    pdfdoc="$(fd . -e pdf | fzf)"
    if [ -z "$pdfdoc" ]; then
        return
    elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
       zathura --fork "$pdfdoc" && exit 
    else
        devour zathura "$pdfdoc"
    fi
}
alias fpdf='pdf'
# alias fpdf='pdf "$(fd . -e pdf | fzf)"'
# alias fpdf='zathura --fork "$(fd . -e pdf | fzf)" && exit'

# tmux
bindkey -s '^ ' "tmuxsessionizer\n"
# bindkey -s '^@' "tmuxsessionizer\n"
alias t=tmuxsessionizer
alias ta="tmux attach"
alias tmls="tmux ls"
alias tmcheat="nvim -O $HOME/.config/tmux/tmux-cht-languages $HOME/.config/tmux/tmux-cht-command"

# Edit configs
alias zshrc="nvim ~/.config/zsh/.zshrc"
alias xinitrc="nvim ~/.xinitrc"
alias vimrc="nvim ~/.config/vim/.vimrc"
alias nviminit="nvim ~/.config/nvim/init.lua"
alias tmuxconf="nvim ~/.config/tmux/tmux.conf"
alias riverconf="nvim ~/.config/river/init"
alias hyprconfig="nvim ~/.config/hypr/hyprland.conf"

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
        selection="$(fzf --no-preview --reverse --border)"
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
        echo "%B%F{$ash}($(parse_git_branch)$(parse_git_dirty)) "
    fi
}

PROMPT='%B%F{$blue2}  %B%F{$green}%~ $(git_status)%B%F{$blue2} %b%F{$white}'
# RPROMPT='%b%F{$white}%T'
# PROMPT="%B%F{$red}[%F{$yellow}%n%F{$green}@%F{$blue2}%M %F{$pink}%~%F{i$red}]%F{$green}$(git_status)$%{$reset_color%}%b "

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

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#757575"
# Load zsh plugins
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf
export FZF_DEFAULT_OPTS="--no-preview"
# export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always {}'"
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"


[ -f "/home/rs/.ghcup/env" ] && . "/home/rs/.ghcup/env" # ghcup-env
