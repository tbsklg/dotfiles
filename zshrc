# Environment
export LANG=en_US.UTF-8
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.luarocks/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git brew zsh-autosuggestions zsh-syntax-highlighting web-search)
source $ZSH/oh-my-zsh.sh

# Pure prompt (single-line)
PURE_PROMPT_SYMBOL=' λ'
autoload -U promptinit; promptinit
prompt pure
prompt_newline=''

# Aliases
alias v="nvim"

# Tools
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

# Language environments
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
[ -s "$HOME/.luaver/luaver" ] && . "$HOME/.luaver/luaver"
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null

# Block cursor on every prompt
zle-line-init() { echo -ne '\e[1 q' }
zle -N zle-line-init
