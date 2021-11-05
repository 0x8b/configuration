alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

for name in ls {,v}dir {,f,e}grep ; do
  eval "alias $name=$name --color=auto"
done

alias ll='ls -AlF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

alias cl='clear'
alias rm='rm -i'
alias mv='mv -i'

if command -v youtube-dl &> /dev/null; then
  alias youtube-dl-mp3='youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0 --output "~/Downloads/%(title)s.%(ext)s"'
fi

if command -v tldr &> /dev/null; then
  alias tldr='tldr --color always'
fi
