#!/bin/bash
#
#
printf -v OFS "${OFS-\t}"
printf -v ORS "${ORS-\n}"
PROG="${0##*/}"
DATA="${1}"

[[ -r "${DATA}" ]] || {
  printf >&2 '%s\n' "Usage: $PROG /path/to/UnicodeData.txt" \
  '    see http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt'
  exit 1 
}
 
declare codepoint description character
declare -a M 
declare -i N
# main()
{ 
  while IFS=\; read -r -a M ; do 
      [[ ${M[0]} == *#* ]] && continue
      codepoint="${M[0]}"
      description="${M[10]} ${M[1]}"
      description="${description##[[:space:]]}"
      description="${description%%[[:space:]]}"
      printf -v character "\U${codepoint}"
      character="${character//[![:word:]]/}"
      character="${character//[[:space:][:blank:][:cntrl:]]/}"
      printf "%-12s\t  %s  \t%s\n" \
          "U+${codepoint}" "${character}" "${description}"
  done 
}  < "${DATA}" 

