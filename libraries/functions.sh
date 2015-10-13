#######################################
# Crude way to clear the screen for new
# data.
#######################################
clear_buffer() {
  printf "\033[?1049h\033[H" ;
}


