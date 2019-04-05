#!/bin/bash
cd /data/imx-yocto-bsp
MACHINE=$Y_MACHINE source fsl-setup-release.sh -b build_$Y_MACHINE

# updating sanity
sed -i 's/INHERIT += "sanity"/INHERIT += ""/g' /data/imx-yocto-bsp/sources/poky/meta/conf/sanity.conf

#Step 5 - choose project image (5.2)
bitbake $Y_IMAGE
