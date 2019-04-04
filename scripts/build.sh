#!/bin/bash
cd /data/imx-yocto-bsp
MACHINE=$MACHINE source fsl-setup-release.sh -b build_$MACHINE

# updating sanity
sed -i 's/INHERIT += "sanity"/INHERIT += ""/g' /data/imx-yocto-bsp/sources/poky/meta/conf/sanity.conf

#Step 5 - choose project image (5.2)
bitbake $IMAGE
