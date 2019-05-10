# Docker architecture

The basic setup of the container can be seen by looking at the `Dockerfile` provided in the repository.

## Container definition
* Ubuntu LTS 18.04
* the build packages as explained in the yocto setup document (installed via apt-get)
* the repo sync tool
* this repository itself
* release tools for Github (may be moved to different container later)

## Container startup
The entrypoint of the container is the `startup.sh`. The script has two functions

* pull the lastest revision of this repository
* start the `build.sh`

The `build.sh` kicks of the build process. The build process can be customized by
* using environmental variables as described in this documentation
* adding custom scripts to the /scripts folder of your repository. The `build.up.sh` script checks if `step01.sh` to `step05.sh` exist. If yes, they are being executed along the process.


## Container data directories

The container three main directories.

1. `/drone/custombuild` contains your repository
1. `/repo/yoctoDocker` contains this repository
1. `/data/` is the working directory for the build

During execution of `build.sh` config, source and scripts are copied from `/drone/custombuild` to `/data`
