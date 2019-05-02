#!/bin/bash
echo starting up
git -C /repo/yoctoDocker pull
/repo/yoctoDocker/build.sh
