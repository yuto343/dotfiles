# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ================================================================
# Plugin settings
# ================================================================
# custom-theme

export LANG=""
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

# syntax-highlight
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# auto-suggestions
zplug "zsh-users/zsh-autosuggestions"
bindkey '^E' end-of-line

zplug romkatv/powerlevel10k, as:theme, depth:1

# zplug "zsh-users/zsh-completions"

#
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load


## コマンド履歴検索
function peco-history-selection() {
  BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

eval "$(anyenv init -)"

fpath=(
  ${HOME}/.zsh/completions
  ${fpath}
)

autoload -Uz compinit
compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# グローバル node_modulesにパスをとおす
export PATH=$PATH:`npm bin -g`

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# tigの文字化け対策
export LC_ALL=en_US.UTF-8
