#!/bin/bash

# Step 1 - run once
git config --global user.name "$GIT_NAME" && git config --global user.email "$GIT_EMAIL" && echo "N" | repo init -u https://source.codeaurora.org/external/imx/imx-manifest  -b imx-linux-rocko -m imx-4.9.88-2.0.0_ga.xml

# Step 2- run once
repo sync

# Step 3- run once (choose from chapter 5.1)
DISTRO=$DISTRO MACHINE=$MACHINE source fsl-setup-release.sh -b build_$MACHINE

#Step 3.b - for rebuild run without DISTRO
#MACHINE=$MACHINE source fsl-setup-release.sh -b build_$MACHINE

# Step 4 check conf folders

sed -i 's/INHERIT += "sanity"/INHERIT += ""/g' /data/imx-yocto-bsp/sources/poky/meta/conf/sanity.conf

#Step 5 - choose project image (5.2)
bitbake $IMAGE
