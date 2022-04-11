#!/bin/bash

root=$(git rev-parse --show-toplevel)

if [ "$1" = "build" ]; then
  pushd "$root"/server || exit; make build; popd || exit
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "install" ]; then
  pushd "$root"/server || exit; make install; popd || exit
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "lint" ]; then
  pushd "$root"/server || exit; make lint; popd || exit
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "run" ]; then
  ./server/target/release/server
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "test" ]; then
  pushd "$root"/server || exit; make test; popd || exit
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
else
  echo "Invalid argument: $1"
  ret=1
fi

exit $ret
