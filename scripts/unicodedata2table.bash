#!/bin/bash
#
#
printf -v OFS "${OFS-\t}"
printf -v ORS "${ORS-\n}"
PROG="${0##*/}"
DATA="${1:-/usr/share/unicode-character-database/UnicodeData.txt}"


# TODO Locate UnicodeData*.txt
#while [[ -z "$DATA" ]] || [[ ! -r "${DATA}" ]] ; do
# do stuff 
#done

[[ -r "${DATA}" ]] || {
  printf >&2 '%s\n' "Usage: $PROG /path/to/UnicodeData.txt" \
  'The latest UnicodeData.txt file can be downloaded from:'
  '    http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt'
  exit 1 
}
declare codepoint description character
declare -a M 
declare -i N
# main()
{ 
  while IFS=\; read -r -a M
  do 
      [[ ${M[0]} == *#* ]] && continue
      codepoint="${M[0]}"
      description="${M[10]} ${M[1]}"
      description="${description##[[:space:]]}"
      description="${description%%[[:space:]]}"
      printf -v character "\U${codepoint}"
      # Unicode Rendering often gets these classes wrong.
      #character="${character//[![:print:]]/}"
      #character="${character//[[:space:][:blank:][:cntrl:]]/}"
      printf "%-12s${OFS}%s${OFS}%s${ORS}" \
          	"U+${codepoint}" "${character}" "${description}"
  done 
}  < "${DATA}" 

