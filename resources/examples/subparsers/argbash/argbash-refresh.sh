#!/usr/bin/env bash

# (c) Erik Dannenberg <erik.dannenberg@xtrade-gmbh.de>
#
# variable conventions:
#
# environment     : SOME_VAR
# readonly        : _SOME_VAR
# local           : some_var
# global          : _some_var
# function return : __function_name

_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" \
    || die "Error, couldn't determine the script's running directory, aborting" 2

command -v argbash >/dev/null 2>&1 || { echo >&2 "--> Error, please install argbash first! Aborting."; exit 1; }

function main() {
    local arg_file

    echo "--> Refreshing Argbash parsers in ${_script_dir}:"

    cd "${_script_dir}"
    for arg_file in *.m4 *.sh; do
        if [[ "${arg_file}" != "argbash-refresh.sh" ]]; then
            echo "${arg_file}"
            argbash -o "${arg_file}" "${arg_file}" --library
        fi
    done
    echo "--> Done"
}

main "@"
