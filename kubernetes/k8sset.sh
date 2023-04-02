#!/bin/bash
COLUMNS=1
PS3="select target cluster: "
IFS="
"
select var in `kubectl config get-contexts | grep -v NAME | grep -v "*" | awk '$0=$1'`
do
  if [ "$var" == "" ]; then
    echo "Your input ($REPLY) is bad."
    exit
  fi
  echo " "${REPLY}") "${var}
  kubectl config use ${var}
  echo "-------------------------------------"
  kubectl config get-contexts
  echo "-------------------------------------"
  exit
done
