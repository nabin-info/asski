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

{ 
    while read -e -r line ; do 
        E=$(\ls -1 asski.* | sort -R | sed -n 1p)
        #tput cuu1
        echo "$line" | $E
    done  
} 

