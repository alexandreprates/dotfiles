#!/usr/bin/env bash

# Executa o comando em background no diretorio atual
function background {
  $1 . > /dev/null 2>&1 &
}

# chown me all files in dir
function reown {
  GROUP=$(id -gn)
  # find . -path ./tmp -prune -o \! -user $USER -exec sudo chown $USER:$GROUP -v {} \;
  find . -not -path "*/node_modules/*" -not -path "*/logs/*" -not -path "*/tmp/*" -not -user $USER -exec sudo chown $USER:$GROUP -v {} \;
}

function backup {
  FILENAME=$(pwd | rev | cut -d "/" -f 1 | rev)
  tar -cjvf ../backup-$FILENAME-`date +"%F"`.tar.bz2 --exclude .git --exclude tmp --exclude logs  --exclude log .
}

function docker-stop() {
  docker ps | rev | cut -d " " -f 1 | rev | grep $1 | xargs docker stop
}

function docker-stall() {
  docker ps -q | xargs docker stop
}

function docker-login-aws() {
  aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
}
