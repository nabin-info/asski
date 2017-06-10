#!/bin/bash
# TODO: just search the path manually for all asski.*
[[ -n "${ASSKIS}" ]] || {
	ASSKIS="$(which asski.ff00)"
	ASSKIS="$(dirname "${ASSKIS}")"
}
cd "${ASSKIS}" && [[ -e asski.ff00 ]] || {
	printf >&2 "FATAL: could not find asski.ff00 in your PATH\n"
	exit 2
}

if [[ $# -eq 0 ]] ; then
	read -r msg
else
	printf -v msg '%s ' "$@"
fi

for a in $(ls -1 asski.* | sort -n) ; do
	printf '%s:\t' "$a"
	${a} <<< "$msg"
done
printf '\n'

