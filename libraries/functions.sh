#######################################
# Clear screen without filling
# scrollback buffer.
#######################################
clear_buffer() {
  #printf "\033[?1049h\033[H" ;
  echo -e "\033c\e[3J"
}

#######################################
# Checks if measurement data is bad.
#######################################
is_bad_data() {
  local measurement_data=$1
  [ -z "${measurement_data}" ] && return 1

  if [ $( echo "scale=2; ${measurement_data} == 9999" | bc ) -eq 1 ]; then
    return 0
  else
    return 1
  fi
}
