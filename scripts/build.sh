#!/bin/bash

echo ===========================================================================
echo ==
echo == Dockerized yocto builder
echo == maintained by Till Witt
echo == Version 0.06
echo ==
echo == User: $GIT_NAME
echo == Mail: $GIT_EMAIL
echo ==
echo == Distro: $Y_DISTRO
echo == Machine: $Y_MACHINE
echo ==
echo ===========================================================================

echo == git repo latest commit
git -C /repo/yoctoDocker log -1 --format=%cd



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
if [ "1" != "$disable_sync" ]
  then
    /root/bin/repo sync
  else
    echo syncing repository disabled
fi

# Step 3- run once (choose from chapter 5.1)
echo
echo ===========================================================================
echo == setting up release
echo ===========================================================================

if [ "1" != "$disable_setup" ]
  then
    EULA=1 DISTRO=$Y_DISTRO MACHINE=$Y_MACHINE source fsl-setup-release.sh -b build  > /data/log_setup.txt 2>&1
  else
    echo setup up release disabled
fi

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
if [ "1" != "$disable_bake" ]
  then
    bitbake $Y_IMAGE > /data/log_bake.txt 2>&1
  else
    echo bake disabled
fi



echo ===========================================================================
echo == release
echo ===========================================================================
if [ "1" != "$disable_release" ]
  then
    #Step 6 - create release
    d=$(date +%Y%m%d_%H%M%S)
    releasename="img--$Y_DISTRO--$Y_MACHINE--$d.zip"
    echo $releasename
    zip -r "$releasename" /data/build/tmp/deploy/images/*

    # making sure the files exist
    if [ ! -f /data/log_bake.txt ]; then
        mkdir -p /data
        echo "log setup was not created during build process!" > "/data/log_bake.txt"
    fi
    if [ ! -f /data/log_bake.txt ]; then
        mkdir -p /data
        echo "log setup was not created during build process!" > "/data/log_bake.txt"
    fi
    if [ ! -f /data/log_setup.txt ]; then
        echo "log setup was not created during build process!" > "/data/log_setup.txt"
    fi
    if [ ! -f /data/sources/meta-freescale/EULA ]; then
        mkdir -p /data/sources/meta-freescale/
        echo "EULA was not created during build process!" > "/data/sources/meta-freescale/EULA"
    fi
    if [ ! -f "$releasename" ]; then
        echo "$releasename was not created during build process!" > $releasename
    fi
    # upload to github
    github-release upload \
      --owner $GITHUB_USER \
      --repo $GITHUB_REPO \
      --tag "$Y_DISTRO-$Y_MACHINE-$d" \
      --name "$Y_DISTRO - $Y_MACHINE ($d)" \
      --body "Yocto Build results - EULA of build components applies" \
    "$releasename" "/data/log_bake.txt" "/data/log_setup.txt" "/data/sources/meta-freescale/EULA"
  else
    echo disable release
fi
