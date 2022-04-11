#!/bin/bash

root=$(git rev-parse --show-toplevel)

if [ "$1" = "build" ]; then
  pushd "$root"/server || exit; make docker; popd || exit
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
  # TODO: Build Docker for web
elif [ "$1" = "clean" ]; then
  docker-compose -f "$root"/compose.yml stop
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
  docker-compose -f "$root"/compose.yml rm -f
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "run" ]; then
  docker-compose -f "$root"/compose.yml pull
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
  docker-compose -f "$root"/compose.yml up -d
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
else
  echo "Invalid argument: $1"
  ret=1
fi

exit $ret
