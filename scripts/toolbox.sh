export EDITOR=vim
export PATH="$PATH:/home/aprates/Workspace/lab/build"

alias be="bundle exec"
alias bi="bundle install"
alias open="xdg-open"
alias xgitg="gitg . > /dev/null 2>&1 &"
alias xmeld="meld . > /dev/null 2>&1 &"

function checktoolbox {
  echo "Toolbox lodaded!"
}

# Adding current dir to autojump
function jadd {
  j --add `pwd`
}

# Find for text into ruby/erb files (recursively)
function codesearch {
  grep $1 * -Rn --include \*.rb --include \*.erb
}

function greenp {
  sed ''/$1/s//`printf "\033[32m$1\033[0m"`/'' $2 ;
}

function here {
  $1 . > /dev/null 2>&1 &
}

#   Docker functions

function drestart {
  clear && docker stop $1 && docker start -ai $1
}

function dbash {
  clear && docker exec -it $1 /bin/bash
}

function dlogs {
  clear && docker logs -f --tail 0 $1
}
