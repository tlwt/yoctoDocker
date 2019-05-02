#!/bin/bash

# setup basis
apt-get update -y && apt-get upgrade -y
apt-get install -y docker.io docker-compose

#clone repo
git clone https://github.com/tlwt/yoctoDocker && cd yoctoDocker

#start container
cd yoctoDocker
docker-compose up &

#connect to container
#docker exec -it yoctodocker_compiler_1 /bin/bash
