export LANG=en_US.UTF-8
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/tbsklg/.local/bin:$PATH
export PATH="/opt/homebrew/opt/llvm@13/bin:$PATH"
export PATH="$HOME/.luarocks/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

plugins=(
 git
 brew
 zsh-autosuggestions
 zsh-syntax-highlighting
 web-search
)

source $ZSH/oh-my-zsh.sh

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

source <(ng completion script)

export PATH="/opt/homebrew/opt/llvm@13/bin:$PATH"

[ -f "/Users/tbsklg/.ghcup/env" ] && source "/Users/tbsklg/.ghcup/env"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

autoload -U promptinit; promptinit
prompt pure

[ -s ~/.luaver/luaver ] && . ~/.luaver/luaver

