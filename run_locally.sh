#!/bin/bash

repo=$(echo "${PWD##*/}" | tr [A-Z] [a-z])


[[ -z $1 ]] && TAG=$(date +%F) || TAG=$1
MYHUBID=larsvilhuber
MYIMG=$repo

docker run -it --rm -v "$(pwd)":/home/rstudio -w /home/rstudio $MYHUBID/$MYIMG:$TAG Rscript programs/master.R

