#!/bin/bash

path=$1

if grep --quiet NoDisplay=true $1; then
  :
else
  echo NoDisplay=true >> $1
fi
