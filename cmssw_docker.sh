#!/bin/bash

Help()
{

	cat <<-END
	${0##*/}: Script for installing the CMS software (CMSSW)

	Usage:

		--build
			Build the container image from the Dockerfile
		
		--image <image>
			Sets the container image. (default: deros/cmssw-cc7)

	END
	exit
}

Build(){

	IMAGE=cmssw_custom
	BUILDCMD="docker build --no-cache -t ${IMAGE} ."
	${BUILDCMD}
	echo To run this custom container ensure cmssw-docker is not running and use the following command:
  echo "${0##*/} -t ${IMAGE}"
  exit

}

cmssw_docker()
{
	NAME=cmssw_docker_$USER
	IMAGE=${IMAGE:-"marcosderos/cmssw-docker"}
	LOCALDIR=$HOME/cmssw-container
  WORKDIR=/home/cmsusr
	if [[ ! -d "$HOME/cmssw-container" ]] 
	then
		mkdir -p $LOCALDIR
		chmod 700 $LOCALDIR
	fi
 
	RUN_DOCKER="docker run --name $NAME --privileged -d -it -v $LOCALDIR:$WORKDIR $IMAGE"
	ENTER_DOCKER="docker exec -it $NAME zsh"
	START_DOCKER="docker start $NAME"
	# check if there is a cmssw-docker
  #docker_check=$( docker images -q $NAME ) 
	if [ $( docker ps -a | grep ${NAME} | wc -l ) -gt 0 ]
	then
		${START_DOCKER}
		${ENTER_DOCKER}
	else
		${RUN_DOCKER}
		${ENTER_DOCKER}
	fi

}

while [ $# -gt 0 ]; do
	case $1 in
		--build)
			Build
    	exit
			;;
	  --image)
			IMAGE=$2
			shift 2
			;;
	esac
done 


cmssw_docker

