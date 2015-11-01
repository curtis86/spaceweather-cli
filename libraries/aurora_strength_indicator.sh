#!/bin/bash
# ARG1: Bz (in nT)
# ARG2: Particle density (in p/cc)
# Prediction formula: (( Bz * -1 * 14 ) + ( Pd * 5 )) / 2 = chance/strength percent

aurora_strength_indicator() {
  local e_args=2 ; [ $# -ne ${e_args} 2>/dev/null ] && exit 1

  local bz=$1
  local pd=$2

  local _percent_chance="$( echo "scale=3; (( ${bz} * -1 * 14) + ( ${pd} * 5)) /2" | bc )"

  if [ $( echo "scale=2; ${_percent_chance} < 0" | bc ) -eq 1 2>/dev/null ]; then
    _percent_chance=0
  fi

  # Make ASCII bar
  local max_elements=20

  local bar_elements="$( echo "scale=2; ${_percent_chance} / 100 * 20" | bc )"
  local bar_elements=${bar_elements%.*} ; [ -z "${bar_elements}" ] && bar_elements=0
  [ $( echo "scale=2; ${bar_elements} > ${max_elements}" | bc ) -eq 1 ] && bar_elements=${max_elements}

  local bar_count=0
  while [ ${bar_count} -lt ${bar_elements} ]; do
    ((bar_count++))
    bar="=${bar}"
  done

  local remaining_space=$((max_elements - bar_elements))

  local empty_count=0
  while [ ${empty_count} -ne ${remaining_space} ]; do
    ((empty_count++))
    empty_space="_${empty_space}"
  done


  # Forecast strings
  local forecast_string="UNKNOWN"

  if [ $( echo "scale=2; ${_percent_chance} <= 10" | bc ) -eq 1 2>/dev/null ]; then
    forecast_string="NONE"
  elif [ $( echo "scale=2; ${_percent_chance} <= 30" | bc) -eq 1 2>/dev/null ]; then
    forecast_string="VERY LOW"
  elif [ $( echo "scale=2; ${_percent_chance} <= 40" | bc) -eq 1 2>/dev/null ]; then
    forecast_string="LOW"
  elif [ $( echo "scale=2; ${_percent_chance} <= 70" | bc) -eq 1 2>/dev/null ]; then
    forecast_string="MEDIUM"
  elif [ $( echo "scale=2; ${_percent_chance} <= 80" | bc) -eq 1 2>/dev/null ]; then
    forecast_string="HIGH"
  elif [ $( echo "scale=2; ${_percent_chance} <= 100" | bc ) -eq 1 2>/dev/null ]; then
    forecast_string="VERY HIGH"
  elif [ $( echo "scale=2; ${_percent_chance} >= 101" | bc ) -eq 1 2>/dev/null ]; then
    forecast_string="EXTREMELY HIGH"
  fi

  echo "[${bar}${empty_space}] ${_percent_chance} % (${forecast_string})"
}
