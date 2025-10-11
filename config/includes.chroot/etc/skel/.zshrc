# Zsh configuration with fancy prompt

# Enable colors
autoload -U colors && colors

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

# Enable completion
autoload -Uz compinit
compinit

# Enhanced completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Load zsh-autosuggestions if available
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting if available (must be last)
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Git prompt function
git_prompt() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        local status=$(git status --porcelain 2>/dev/null)
        local color="%F{green}"
        
        if [ -n "$status" ]; then
            color="%F{yellow}"
        fi
        
        echo " ${color}(${branch})%f"
    fi
}

# Custom prompt with colors and git support
setopt PROMPT_SUBST
PROMPT='%F{cyan}╭─%f %F{blue}%n%f%F{white}@%f%F{magenta}%m%f %F{yellow}%~%f$(git_prompt)
%F{cyan}╰─%f %F{green}❯%f '

# Right prompt with time
RPROMPT='%F{244}%*%f'

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Key bindings
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char
