#######################################
# Clear screen without filling
# scrollback buffer.
#######################################
clear_buffer() {
  #printf "\033[?1049h\033[H" ;
  echo -e "\033c\e[3J"
}

#######################################
# Prints script usage
#######################################
usage() {
  echo
  echo "Usage: $( basename $0 ) <options>"
  echo
  echo "Options:"
  echo "  --single:  runs once and then exits."
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

#######################################
# Gets latest measurements
#######################################
get_measurements() {
  date_now=$( date )
  wing_kp_index_current=$( ${spaceweather_f} "m_wing_kp_index" | awk '{ print $2 }' ) || abrt "ERROR: Unable to retrieve reading. Exiting."
  wing_kp_index_onehour=$( ${spaceweather_f} "m_wing_kp_one_hour_forecast" | awk '{ print $2 }' ) || abrt "ERROR: Unable to retrieve reading. Exiting."
  wing_kp_index_fourhour=$( ${spaceweather_f} "m_wing_kp_four_hour_forecast" | awk '{ print $2 }' ) || abrt "ERROR: Unable to retrieve reading. Exiting."
  ace_magnetometer_bz=$( ${spaceweather_f} "m_ace_magnetometer_bz" | awk '{ print $2 }' ) || abrt "ERROR: Unable to retrieve reading. Exiting."
  ace_solar_wind_speed=$( ${spaceweather_f} "m_ace_solar_wind_speed" | awk '{ print $2 }' ) || abrt "ERROR: Unable to retrieve reading. Exiting."
  ace_solar_wind_eta=$( ${spaceweather_f} "m_ace_solar_wind_eta" | awk '{ print $2 }' ) || abrt "ERROR: Unable to retrieve reading. Exiting."
  ace_particle_density=$( ${spaceweather_f} "m_ace_particle_density" | awk '{ print $2 }' ) || abrt "ERROR: Unable to retrieve reading. Exiting."
}

#######################################
# Prints last measurements
#######################################
print_measurements() {
  echo -n "Current Kp Index: " && is_bad_data ${wing_kp_index_current} && echo "*bad reading*" || echo "${wing_kp_index_current}"
  echo -n "1-Hour Forecast Kp Index: " && is_bad_data ${wing_kp_index_onehour} && echo "*bad reading*" || echo "${wing_kp_index_onehour}"
  echo -n "4-hour Forecast Kp Index: " && is_bad_data ${wing_kp_index_fourhour} && echo "*bad reading*" || echo "${wing_kp_index_fourhour}"
  echo -n "ACE Bz: " && is_bad_data ${ace_magnetometer_bz} && echo "*bad reading*" || echo "${ace_magnetometer_bz} nT"
  echo -n "ACE Particle Density: " && is_bad_data ${ace_particle_density} && echo "*bad reading*" || echo "${ace_particle_density} p/cc"
  echo -n "ACE Solar Wind: " && is_bad_data ${ace_solar_wind_speed} && echo "*bad reading*" || echo "${ace_solar_wind_speed} Km/s"
  echo -n "Solar Wind ETA: " && is_bad_data ${ace_solar_wind_eta} && echo "*bad reading*" || echo "${ace_solar_wind_eta} minutes."
  echo "Last Update: ${date_now}"
  echo

  if ! is_bad_data ${ace_magnetometer_bz} && ! is_bad_data ${ace_particle_density}; then
    echo "Aurora Prediction: $( aurora_strength_indicator ${ace_magnetometer_bz} ${ace_particle_density} )"
  else
    echo "Aurora Prediction: *bad measurement reading*"
  fi
}
