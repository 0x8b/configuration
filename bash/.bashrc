# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi

unset rc

if [[ -d "$HOME/.asdf" ]]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
fi

[[ -d "$HOME/.cargo" ]] && source $HOME/.cargo/env

eval "$(starship init bash)"

function mkcd {
  mkdir -pv -- "$1" && cd -- "$1" || exit
}

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

function config {
  case $1 in
    "edit")
      if path="$(FZF_DEFAULT_COMMAND='fd . ~/.configuration --type=f --ignore-case --no-ignore --hidden --exclude=.git' fzf --query "$2" --select-1 -i --exact)" ; then
        [ -f "$path" ] && nvim "$path"
      fi
      ;;
    *)
      git --git-dir="$HOME/.configuration/.git" --work-tree="$HOME/.configuration" "$@"
      ;;
  esac
}

function git {
  if [[ "$1" == "peek" ]] ; then
    if [[ -n "$2" ]] ; then
      local repo="$2"
      local tmpdname

      tmpdname="$(mktemp -d --suffix='-git-peek')"

      if [[ ! "$repo" =~ ^https ]] ; then
        repo="https://github.com/${repo}"
      fi

      git clone --depth 1 "$repo" "$tmpdname" || return

      echo "${tmpdname} # ${repo}" >> ~/.git-peek

      cd "$tmpdname" || exit # undo by `cd -`

      return
    fi

    if [[ -f ~/.git-peek ]] ; then
      alive=$(mktemp)

      while read -r dname ; do
        [[ -d ${dname%% *} ]] && echo "$dname" >> "$alive"
      done < ~/.git-peek

      cp "$alive" ~/.git-peek

      if dname="$(fzf -i --select-1 --exit-0 < ~/.git-peek)" ; then
        cd ${dname%% *} || exit
      fi
    fi

    return
  else
    /usr/bin/git "$@"
  fi
}

export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'

[[ -d "$HOME/.cargo" ]] && PATH="$PATH:$HOME/.cargo/bin"

[[ -d "$HOME/.asdf" ]] && . $HOME/.asdf/asdf.sh && . $HOME/.asdf/completions/asdf.bash

export STARSHIP_CONFIG=~/.config/starship/starship.toml
export EDITOR=nvim
export PATH
