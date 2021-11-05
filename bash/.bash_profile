[[ -d "$HOME/.cargo" ]] && PATH="$PATH:$HOME/.cargo/bin"

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export EDITOR=nvim
export PATH
export STARSHIP_CONFIG=~/.config/starship/starship.toml
