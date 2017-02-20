#!/usr/bin/env bash

function main() {
    if [ "$_arg_print" = on ]
    then
      echo "Positional arg value for foo command: '$_arg_foo_arg'"
      echo "Optional arg '--foo-option' value: '$_arg_foo_option'"
    else
      echo "Not telling anything, print not requested"
    fi
}

main "$@"
