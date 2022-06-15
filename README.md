# cmssw-cc7-docker

CERN CentOS7 (cc7) docker container with pre-requisites for running cmssw.

## Instructions 

### Pre-requisites

* [Docker](https://docs.docker.com/engine/install/) must be installed.

1) Using image from DockerHub

1. Get the repository:
		
		`$ git clone `

2. Enter and type:

		`$ cd cmssw-cc7-docker `

		`$ ./cmssw_docker.sh `
	
By default, it will pull the `marcosderos/cmssw-docker`, but if you want other image you can add by using the tag `--image <image>`. Once you entered at the container, you can use the [script for stalling cmssw](https://github.com/maoderos/cmssw-install.git).



