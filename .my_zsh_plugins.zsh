source ~/.zplug/init.zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/vi-mode",   from:oh-my-zsh
zplug "rupa/z"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zdharma/fast-syntax-highlighting"
zplug load --verbose
bindkey '^ ' autosuggest-accept
(( ${+aliases[z]} )) && unalias z
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}
zz() {
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}
alias j=zz
alias jj=z
