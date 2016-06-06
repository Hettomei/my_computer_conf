#!/bin/bash

if [ $# -lt 2 ]
then
  echo "Need to be run like this"
  echo "./notify.sh 11h43 'Va manger'"
  echo "./notify.sh 16h13 'Va manger'"
  exit 1
fi

echo "Demande de sleep pour $1, avec le message $2"
echo "Heure actuelle : " $(date "+%Hh%M")

while :
do
  sleep 1
  if [ "$1" == "$(date "+%Hh%M")" ]; then
    break
  fi
done

while :
do
  echo "$2"
  notify-send MESSAGE "$2, jobs : $$"
  sleep 7
done
