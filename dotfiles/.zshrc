# Default Configuration
export HISTSIZE=50
export SAVEHIST=500
export HISTFILE="${HOME}/.zsh_history"

setopt histignorespace
# Add ~/.local/bin to PATH
export PATH=${PATH}:${HOME}/.local/bin:${HOME}/.cargo/bin:${HOME}/.gem/ruby/2.5.0/bin

# VISUAL
export VISUAL="vim"

# Ruby Gem Installation Path
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

# Pure Prompt
autoload -U promptinit; promptinit
prompt pure
