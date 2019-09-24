#!/usr/bin/env bash

function docker-stop() {
  docker ps | rev | cut -d " " -f 1 | rev | grep $1 | xargs docker stop
}
