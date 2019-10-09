if [[ ! -d ~/.zplug ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
source ~/.zplug/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "lib/theme-and-appearance", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/grep", from:oh-my-zsh
zplug "lib/termsupport", from:oh-my-zsh
zplug "themes/ys", from:oh-my-zsh, as:theme
zplug "rupa/z", use:z.sh
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install zplug plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load # --verbose
bindkey '^ ' autosuggest-accept
(( ${+aliases[z]} )) && unalias z
z() {
    cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
