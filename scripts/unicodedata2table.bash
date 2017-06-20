#!/bin/bash
#
#
: "${OFS:=\t}" "${ORS:=\n}"
PROG="${0##*/}"

set | grep 'O[RF]S'

case $1 in 
  --compose) MODE=${1#--} ; shift ;;
  --switch)  MODE=${1#--} ; shift ;;
  --tab)     MODE=${1#--} ; shift ;;
  --)       shift ;;
   *) true ;;
esac
MODE="${MODE:-tab}"
DATA="${HOME}/.unicode.data"
CASH="${HOME}/.unicode.${MODE}"
for data in \
  "$DATA" \
  ./UnicodeData.txt \
  "${HOME}/share/UnicodeData.txt" \
  /usr/share/unicode-character-database/UnicodeData.txt \
  /usr/share/UnicodeData.txt \
  /usr/lib/UnicodeData.txt
do 
    [[ -r "$data" ]] && {
    printf >&2 'INFO: caching unicode data file: %s -> %s\n' "${data}" "${DATA}"
    [[ ${data} = ${DATA} ]] \
      && cmp -s "$data" "$DATA" \
      || cp -iv "$data" "$DATA" 
    break
  }
done

[[ -r "${DATA}" ]] || {
  printf >&2 '%s\n' \
      "Usage: $PROG [MODE] [regexp]" \
      'UnicodeData.txt is provided with every update to unicode standard' \
      'and is expected (or, if found, will be cached) in '
      "    ${DATA}" \
      'Archlinux users may obtain via:' \
      '    pacman -S unicode-character-database' \
      'The general solution is to manually download the latest version via:' \
      '    curl -Lo "'"${DATA}"'" "http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt"'
  exit 1 
}


declare codepoint description character
declare -a M 
declare -i N
# main()
[[ "${DATA}" -nt "${CASH}" ]] && { 
  printf >&2 'INFO: using unicode data file: %s\n' "${DATA}"
  while IFS=\; read -r -a M
  do 
      [[ ${M[0]} == *#* ]] && continue
      codepoint="${M[0]}"
      description="${M[10]} ${M[1]}"
      description="${description##[[:space:]]}"
      description="${description%%[[:space:]]}"

      # Unicode Rendering often gets these classes wrong.
      printf -v character "\U${codepoint}"
      character="${character//[![:print:]]/}"
      #character="${character//[[:space:][:blank:][:cntrl:]]/}"

      if [[ "${MODE}" = "tab" ]]; then
        printf "%-12s\t%s\t%s\n" \
            "U+${codepoint}" "${character}" "${description}"

      elif [[ "${MODE}" = "switch" ]]; then
        printf '\tcase 0x%s: return("%s");\n' \
            "${codepoint}" "${description}"

      else
        printf >&2 "FATAL: unknown MODE: %s\n" "$MODE" 
        exit 1
      fi
  done  < "${DATA}" 
} > "${CASH}"

printf >&2 'INFO: reading from cache: %s\n' "${CASH}"
sed -e 's#\t#'"$OFS"'#g' -e 's#$#'"$ORS"'#g' "${CASH}"
