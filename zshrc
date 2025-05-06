export LANG=en_US.UTF-8
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/bin/roc:$PATH
export PATH="/opt/homebrew/opt/llvm@13/bin:$PATH"
export PATH="$HOME/.luarocks/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

export NPM_CONFIG_PREFIX="$HOME/.npm-global"

plugins=(
 git
 brew
 zsh-autosuggestions
 zsh-syntax-highlighting
 web-search
)

# Aliases
alias v="nvim"

source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
prompt pure

[ -f "/Users/tbsklg/.ghcup/env" ] && source "/Users/tbsklg/.ghcup/env"
[ -s ~/.luaver/luaver ] && . ~/.luaver/luaver

source /Users/tbsklg/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/tbsklg/.opam/opam-init/init.zsh' ]] || source '/Users/tbsklg/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
