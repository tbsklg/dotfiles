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

autoload -U promptinit; promptinit
prompt pure

[ -f "/Users/tbsklg/.ghcup/env" ] && source "/Users/tbsklg/.ghcup/env"
[ -s ~/.luaver/luaver ] && . ~/.luaver/luaver

source /Users/tbsklg/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
