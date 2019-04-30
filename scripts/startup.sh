#!/bin/bash

echo ===========================================================================
echo ==
echo == Dockerized yocto builder
echo == maintained by Till Witt - till.witt@nxp.com
echo ==
echo == User: $GIT_NAME
echo == Mail: $GIT_EMAIL
echo ==
echo == Distro: $Y_DISTRO
echo == Machine: $Y_MACHINE
echo ==
echo ===========================================================================
echo
echo ===========================================================================
echo == initialising repository
echo ===========================================================================
cd /data
# Step 1 - run once
git config --global user.name "$GIT_NAME" && git config --global user.email "$GIT_EMAIL" && echo "N" | /root/bin/repo init -u https://source.codeaurora.org/external/imx/imx-manifest  -b imx-linux-rocko -m imx-4.9.88-2.0.0_ga.xml

# Step 2- run once
echo
echo ===========================================================================
echo == syncing repository
echo ===========================================================================
/root/bin/repo sync

# Step 3- run once (choose from chapter 5.1)
echo
echo ===========================================================================
echo == setting up release
echo ===========================================================================

EULA=1 DISTRO=$Y_DISTRO MACHINE=$Y_MACHINE source fsl-setup-release.sh -b build_$Y_MACHINE

#Step 3.b - for rebuild run without DISTRO
#MACHINE=$MACHINE source fsl-setup-release.sh -b build_$MACHINE

# Step 4 check conf folders
echo
echo ===========================================================================
echo == who needs sanity
echo ===========================================================================

sed -i 's/INHERIT += "sanity"/INHERIT += ""/g' /data/sources/poky/meta/conf/sanity.conf


echo
echo ===========================================================================
echo == bakerman is baking ...
echo ===========================================================================
#Step 5 - choose project image (5.2)
bitbake $Y_IMAGE


echo ===========================================================================
echo == release
echo ===========================================================================

d=$(date +%Y%m%d_%H%M%S)
#Step 6 - create release
github-release upload \
  --owner tlwt \
  --repo yoctoDocker \
  --tag "$d" \
  --name "$d" \
  --body "Yocto Build results" \
  /repo/yoctoDocker/data/build_imx6ulevk/tmp/deploy/images/*.*
