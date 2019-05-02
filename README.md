# Yocto compiler for iMX boards

[![Build Status](https://cloud.drone.io/api/badges/tlwt/yoctoDocker/status.svg)](https://cloud.drone.io/tlwt/yoctoDocker)


This is a dockerized build environment for Yocto images to run on i.MX boards for NXP. The environment supports publishing to GITHUB releases.

The scripts / dockerized setup in this repository are open source. Please make yourself familiar with the build results (images) corresponding licenses. The build images are available within the release section.

A lot is based on the [i.MX Yocto Project User's Guide Linux](https://www.nxp.com/docs/en/user-guide/i.MX_Yocto_Project_User's_Guide_Linux.pdf):


## How to get the image on an i.MX board
1. The release section contains a zip file with an `Distro` (e.g. fsl-imx-x11)
 `Machine` (e.g. imx6ulevkand) information and a date & time when the image was build. Download the zip file in the section.
2. Within the ZIP file which is currently (2019-05-01) about 200 MB large you'll find the image file ending on `rootfs.sdcard.bz2` (the date and distro will vary.) e.g.```core-image-base-imx6ulevk-20190429085504.rootfs.sdcard.bz2```
3. Once you downloaded the image you need to execute the following commands:
```bash
bunzip2 -dk -f <image_name>.sdcard.bz2
sudo dd if=<image name>.sdcard  of=/dev/sd<partition> bs=1M conv=fsync
```

From experience, the sd card device usually shows up as /dev/mmcblk0, at least
in modern Ubuntu.

### Thanks to
Without the my colleagues Ahmad, Jan & Nithin the results I would not have been able to set this up.

To manage the GITHUB releases the https://github.com/cheton/github-release-cli tool is used.

### Todos
Look at https://github.com/tlwt/yoctoDocker/issues/ to find out how to help / whats still open.


-----

## How to locally build the build environment
You can run the build process locally in case you don't want to just download the provided images. But be aware that even on up-to-date machines it may take between 4-8 hours. Given a server with a lot of RAM > 128 GB, SSD and around 32 cores - we have a build time of one hour.




## prepare the environment
The build process only requires docker. You can easily install it on a current Ubuntu like this:

```bash
apt-get update -y && apt-get upgrade -y && apt install docker.io docker-compose -y
```

## build
```bash
git clone https://github.com/tlwt/yoctoDocker && cd yoctoDocker && docker-compose up
```

## connect
```bash
docker exec -it yoctodocker_compiler_1 /bin/bash
cd /data
/scripts/startup.sh
```


output is at (the directory depends on the machine you chose during setup)

```bash
/root/yoctoDocker/data/build_imx6ulevk/tmp/deploy/images/imx6ulevk
```

# deploying releases
for github release to work the following environmental variable needs to be set.

---
## docker-compose variables

the following environmental variables need to be set in order for the build process to work:

Your git information:
```
- GIT_EMAIL=witt@consider-it.de
- GIT_NAME=Till Witt
```

The distro, machine and image setting you want to be build:

```
- Y_MACHINE=imx6ulevk
- Y_DISTRO=fsl-imx-x11
- Y_IMAGE=core-image-base
```

In case you want to publish your own releases on GITHUB you need an oauth token from GITHUB. You want to hide this using secrets in your build process.
```
- GITHUB_TOKEN=<secret>
```

For debugging purpose you want to use the following variables to speed up the entire process by skipping certain steps.

```
- disable_sync=1
- disable_setup=1
- disable_bake=1
```
