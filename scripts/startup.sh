#!/bin/bash
echo starting up
git -C /repo/yoctoDocker pull
/repo/yoctoDocker/scripts/build.sh
