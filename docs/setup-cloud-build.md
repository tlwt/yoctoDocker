# Setup a cloud build

This is a quick way to have your own yocto build running within minutes. It requires a few steps:

1. setup your own repository which is internet facing. github is quite good for this.
2. adapt the build configuration files to your needs
3. update the `.drone.yml` to reflect your needs


## GIT repository
the basic folder structure needs to contain:

```bash
/config
        /bblayers.conf.org
        /local.conf.org
/sources
        /...      
```

## Build configuration files
The `bblayers.conf.org`contains additional sources which should be linked. The sources directory can contain either the source files directly in the corresponding subfolders or it can link submodules. They will be cloned during the build process.

## Drone build automation

Drone is the build automation we chose to fetch your source code and build it using the image provided.

`.drone.yml` contains the build step and configuration settings required for the build.

```yml
workspace:
  base: /drone
  path: /custombuild

pipeline:
  submod:
     image: docker:git
     commands:
       - git submodule update --recursive --remote
  build:
    image: tlwt/yoctodocker:latest
    secrets: [ GITHUB_TOKEN ]
    environment:
       - GIT_EMAIL=mail@tillwitt.de
       - GIT_NAME=Till Witt
       - Y_MACHINE=imx6ulevk
       - Y_DISTRO=fsl-imx-x11
       - Y_IMAGE=core-image-base
       - GITHUB_USER=tlwt
       - GITHUB_REPO=imx-x11-imx6ulevk
```
