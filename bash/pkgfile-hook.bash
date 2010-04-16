#!/bin/bash
command_not_found_handle() {
	local _command="${1}"
	local _search="${1}"
	local _ifs=$IFS

	_search="${_search//./\.}"
	_search="${_search//\*/\*}"

	IFS=$'\n'
	local _packages=($(grep "^${_search} " /var/cache/bin.cache))

	if [[ ! -z ${_packages} ]]; then
		echo "Command \`${_command}' may be provided by one of the following packages:"
		echo
		for _line in ${_packages[@]}; do
			echo $_line | awk '{ print $2"/"$3": "$4 }'
		done
	else
		echo "${0}: ${_command}: command not found"
	fi

	IFS=${_ifs}

	return 127
}
