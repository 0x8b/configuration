[[ -d "$HOME/.cargo" ]] && PATH="$PATH:$HOME/.cargo/bin"

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export EDITOR=nvim
export PATH
