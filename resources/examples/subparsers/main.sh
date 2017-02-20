#!/usr/bin/env bash
#
# (c) Erik Dannenberg <erik.dannenberg@xtrade-gmbh.de>
#
# variable conventions:
#
# environment     : SOME_VAR
# readonly        : _SOME_VAR
# local           : some_var
# global          : _some_var
# function return : __function_name

_help_header="My App"
_help_commands="Commands:

foo   - Some description for foo
bar   - Some description for bar

${0} <command> --help for more information
"

# Wrap Argbash's print_help
function show_help() {
    local header_current_cmd
    [[ "${_is_valid_cmd}" == "true" ]] && header_current_cmd=" - ${_arg_command}"
    echo -e "\n${_help_header}${header_current_cmd}\n"
    [[ ! -z "${_help_command_description}" ]] && echo -e "\n${_help_command_description}\n"
    print_help
    # only show command listing if no/invalid command was provided
    if [[ -z "${_arg_command}" ]] || [[ -z "${_is_valid_cmd}" ]]; then
        echo -e "\n${_help_commands}"
    fi
}

# Arguments:
# 1: exit_message as string
# 2: exit_code as int, optional, default: 1
function die() {
    local exit_code
    exit_code=${2:-1}
    echo -e '--#@!>' "$1" >&2
    exit ${exit_code}
}

_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" \
    || die "Error, couldn't determine the script's running directory, aborting" 2

# parse main args
_parser_file="${_script_dir}/argbash/opt-main.sh"
[[ -f "${_parser_file}" ]] && source "${_parser_file}" || die "Error: Couldn't read: ${_parser_file}"

# debug
echo "_arg_print is: ${_arg_print}"

# handle --help for main script, don't display if a command was passed
[[ -z "${_arg_command}" ]] && [[ "${_arg_help}" == "on" ]] \
    && show_help && exit 0

# valid command?
_cmd_script="${_script_dir}/cmd/${_arg_command}.sh"
[[ ! -f "${_cmd_script}" ]] && show_help && die "Error, unknown command: ${_arg_command}"

# parse command args
_parser_file="${_script_dir}/argbash/${_arg_command}.sh"
[[ -f "${_parser_file}" ]] && source "${_parser_file}" "${_arg_leftovers[@]}" || die "Error: Couldn't read: ${_parser_file}"
_is_valid_cmd="true"

# handle --help for command script
[[ "${_arg_help}" == "on" ]] && show_help && exit 0

# run command
source "${_cmd_script}" "${_arg_leftovers[@]}"
