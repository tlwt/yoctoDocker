# Yocto compiler for iMX boards

```
docker-compose build && docker-compose restart && docker exec -it yoctodocker_compiler_1 /bin/bash
```

## Todo

* ```/scripts/*``` need to be made compatible with different releases


Thanks to Jan & Nithin


## setup server
```
apt-get update -y && apt-get upgrade -y && apt install docker.io docker-compose -y
```

or run

## build
```
git clone https://github.com/tlwt/yoctoDocker && cd yoctoDocker && docker-compose up
```

## connect
```
docker exec -it yoctodocker_compiler_1 /bin/bash
cd /data
/scripts/startup.sh
```


output is at

```
/root/yoctoDocker/data/build_imx6ulevk/tmp/deploy/images/imx6ulevk
```
