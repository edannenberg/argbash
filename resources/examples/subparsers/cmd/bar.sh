#!/usr/bin/env bash

function main() {
    if [ "$_arg_print" = on ]
    then
      echo "Positional arg value for bar command: '$_arg_bar_arg'"
      echo "Optional arg '--bar-option' value: '$_arg_bar_option'"
    else
      echo "Not telling anything, print not requested"
    fi
}

main "$@"
