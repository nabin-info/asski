#!/bin/bash
[[ -n "${ASSKIS}" ]] || {
	ASSKIS="$(which asski.ff01)"
	ASSKIS="$(basename "${ASSKIS}")"
}
cd "${ASSKIS}" && [[ -e asski.ff01 ]] || {
	printf >&2 "FATAL: could not find asski.ff01 in your PATH\n"
	exit 2
}

read -r msg

for a in $(ls -1 asski.* | sort -V) ; do
  printf '%s:\t' "$a"
  ${a} <<< "$msg"
done
printf '\n'

