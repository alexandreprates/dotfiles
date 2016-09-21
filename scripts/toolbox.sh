export EDITOR=vim
export PATH="$PATH:/home/aprates/.local/bin"

alias be="bundle exec"
alias bi="bundle install"
alias open="xdg-open"
alias xgitg="gitg . > /dev/null 2>&1 &"
alias xmeld="meld . > /dev/null 2>&1 &"

alias dc="docker-compose"
alias reloadtoobox="source ~/.dotfiles/scripts/toolbox.sh"

function checktoolbox {
  echo "Toolbox lodaded!"
}


# Find for text into ruby/erb files (recursively)
function codesearch {
  grep $1 * -Rn --include \*.rb --include \*.erb
}

function greenp {
  sed ''/$1/s//`printf "\033[32m$1\033[0m"`/'' $2 ;
}

# Executa o comando em background no diretorio atual
function here {
  $1 . > /dev/null 2>&1 &
}

# chown me all files in dir
function giveme {
  sudo chown $USER:$USER *.* -R
  ls -l
}

#   Docker functions

function drestart {
  clear && docker stop $1 && docker start -ai $1
}

function dcrestart {
  clear && docker-compose stop && docker-compose start && docker-compose logs -f --tail 0
}

function drspec {
  clear && docker exec -it $1 bundle exec rspec $2
}

function dbash {
  clear && docker exec -it $1 /bin/bash
}

function dlogs {
  clear && docker logs -f --tail 0 $1
}
