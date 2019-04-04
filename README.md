# Yocto compiler for iMX boards

```
docker-compose build && docker-compose restart && docker exec -it yoctodocker_compiler_1 /bin/bash
```

##Todo

* ```/scripts/*``` need to be made compatible with different releases


Thanks to Jan & Nithin


## setup server
```
apt-get update -y && apt-get upgrade -y
apt install docker.io docker-compose
```

## build
```
git clone https://github.com/tlwt/yoctoDocker
cd yoctodocker
docker-compose up
```

## connect
```
docker exec -it yoctodocker_compiler_1 /bin/bash
cd /scripts
./startup.sh
```
