# How to locally build the build environment
You can run the build process locally in case you don't want to just download the provided images. But be aware that even on up-to-date machines it may take between 4-8 hours. Given a server with a lot of RAM > 128 GB, SSD and around 32 cores - we have a build time of one hour.


## prepare the environment
The build process only requires docker. You can easily install it on a current Ubuntu like this:

```bash
apt-get update -y && apt-get upgrade -y && apt install docker.io docker-compose -y
```

## build
```bash
git clone https://github.com/tlwt/yoctoDocker
cd yoctoDocker
docker-compose up &
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
