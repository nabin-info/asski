#!/bin/bash
[[ -n "${ASSKIS}" ]] || {
	ASSKIS="$(which asski.ff01)"
	ASSKIS="$(basename "${ASSKIS}")"
}
cd "${ASSKIS}" && [[ -e asski.ff01 ]] || {
	printf >&2 "FATAL: could not find asski.ff01 in your PATH\n"
	exit 2
}

{ 
    while read -e -r line ; do 
        E=$(\ls -1 asski.* | sort -R | sed -n 1p)
        #tput cuu1
        echo "$line" | $E
    done  
} 

