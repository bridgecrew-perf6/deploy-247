#!/bin/bash

root=$(git rev-parse --show-toplevel)

if [ "$1" = "build" ]; then
  pushd "$root"/web || exit; yarn run build; popd || exit
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "install" ]; then
  pushd "$root"/web || exit; yarn; popd || exit
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "lint" ]; then
  pushd "$root"/web || exit; yarn run lint; popd || exit
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "run" ]; then
  pushd "$root"/web || exit; yarn run start; popd || exit
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "test" ]; then
  pushd "$root"/web || exit; yarn run test:unit; popd || exit
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
else
  echo "Invalid argument: $1"
  ret=1
fi

exit $ret
