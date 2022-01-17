#!/bin/bash
PWD=$(pwd)
repo=$(echo "${PWD##*/}" | tr [A-Z] [a-z])
space=larsvilhuber
case $USER in
  vilhuber|larsvilhuber)
  WORKSPACE=$HOME/Workspace/git
  ;;
  codespace)
  WORKSPACE=/workspaces
  ;;
esac
  
# build the docker if necessary

docker pull $space/$repo 
BUILD=yes
arg1=$1

if [[ $? == 1 ]]
then
  ## maybe it's local only
  docker image inspect $space/$repo > /dev/null
  [[ $? == 0 ]] && BUILD=no
fi
# override
[[ "$arg1" == "force" ]] && BUILD=yes

BUILD=no
if [[ "$BUILD" == "yes" ]]; then
docker build . -t $space/$repo
nohup docker push $space/$repo &
fi

docker run -e PASSWORD=testing -v $WORKSPACE:/home/rstudio --rm -p 8787:8787 $space/$repo
