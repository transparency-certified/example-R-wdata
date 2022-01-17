#!/bin/bash

repo=$(echo "${PWD##*/}" | tr [A-Z] [a-z])


[[ -z $1 ]] && TAG=$(date +%F) || TAG=$1
[[ -z $2 ]] && MYHUBID=larsvilhuber || MYHUBID=$2
MYIMG=$repo
DOCKERIMG=$MYHUBID/$MYIMG

echo "================================"
echo "Running docker:"
set -ev

# When we are on Github Actions
if [[ $CI ]] 
then
   DOCKEROPTS="--rm"
   #DOCKERIMG=$(echo $GITHUB_REPOSITORY | tr [A-Z] [a-z])
   TAG=latest
else
   DOCKEROPTS="-it --rm"
   #DOCKERIMG=$MYHUBID/$MYIMG
   [[ -z $TAG ]] && TAG=latest
fi

# ensure that the directories are writable by Docker
chmod a+rwX data 


time docker run $DOCKEROPTS \
  -v "$(pwd)":/home/rstudio \
  -w /home/rstudio \
  $DOCKERIMG:$TAG Rscript programs/master.R


