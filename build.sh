#!/bin/bash

repo=$(echo "${PWD##*/}" | tr [A-Z] [a-z])


[[ -z $1 ]] && TAG=$(date +%F) || TAG=$1
MYHUBID=larsvilhuber
MYIMG=$repo

DOCKER_BUILDKIT=1 docker build  . \
  -t $MYHUBID/${MYIMG}:$TAG

echo "docker run -it --rm  $MYHUBID/${MYIMG}:$TAG"
echo "docker push  $MYHUBID/${MYIMG}:$TAG"
