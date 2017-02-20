#!/bin/bash

# ARGBASH_WRAP([opt-global])
# ARG_POSITIONAL_SINGLE([command],[command to run],[])
# ARG_LEFTOVERS([command-options])
# ARG_OPTIONAL_BOOLEAN([help],[h],[Prints help])
# ARGBASH_SET_INDENT([    ])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.3.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info

die()
{
    local _ret=$2
    test -n "$_ret" || _ret=1
    test "$_PRINT_HELP" = yes && print_help >&2
    echo "$1" >&2
    exit ${_ret}
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
_arg_leftovers=()
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_print=off
_arg_help=off

print_help ()
{
    printf 'Usage: %s [--(no-)print] [--(no-)help] <command> ... \n' "$0"
    printf "\t%s\n" "<command>: command to run"
    printf "\t%s\n" "... : command-options"
    printf "\t%s\n" "--print,--no-print: A boolean option with long flag (and implicit default: off) (off by default)"
    printf "\t%s\n" "-h,--help,--no-help: Prints help (off by default)"
}

# THE PARSING ITSELF
while test $# -gt 0
do
    _key="$1"
    case "$_key" in
        --no-print|--print)
            _arg_print="on"
            _args_opt_global_opt+=("${_key%%=*}")
            test "${1:0:5}" = "--no-" && _arg_print="off"
            ;;
        -h*|--no-help|--help)
            _arg_help="on"
            _next="${_key##-h}"
            test -n "$_next" && test "$_next" != "$_key" && shift && set -- "-h" "-${_next}" "$@"
            test "${1:0:5}" = "--no-" && _arg_help="off"
            ;;
        *)
            _positionals+=("$1")
            ;;
    esac
    shift
done

_positional_names=('_arg_command' )
test ${#_positionals[@]} -lt 1 && _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require at least 1, but got only ${#_positionals[@]}." 1
_OUR_ARGS=$((${#_positionals[@]} - ${#_positional_names[@]}))
for (( ii = 0; ii < _OUR_ARGS; ii++))
do
    _positional_names+=("_arg_leftovers[(($ii + 0))]")
done

for (( ii = 0; ii < ${#_positionals[@]}; ii++))
do
    eval "${_positional_names[ii]}=\${_positionals[ii]}" || die "Error during argument parsing, possibly an Argbash bug." 1
done

# OTHER STUFF GENERATED BY Argbash
_args_opt_global=("${_args_opt_global_opt[@]}" "${_args_opt_global_pos[@]}")

### END OF CODE GENERATED BY Argbash (sortof) ### ])