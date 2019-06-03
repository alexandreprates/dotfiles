export EDITOR=vim
export PATH="$PATH:$HOME/.local/bin"

alias reload-toolbox="source ~/.dotfiles/scripts/toolbox.sh; echo Done!"

function toolbox {
  echo "Toolbox available!"
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
function reown {
  find . -path ./tmp -prune -o \! -user $USER -exec sudo chown $USER:$USER -v {} \;
}


function backup {
  FILENAME=$(pwd | rev | cut -d "/" -f 1 | rev)
  tar -cjvf ../backup-$FILENAME-`date +"%F"`.tar.bz2 --exclude .git --exclude tmp --exclude logs  --exclude log .
}