# Setup bare metal

a bare metal build system only requires an up-to-date ubuntu with docker & docker-compose installed.
This can be achieved by executing these or similar commands:

```bash
apt-get update -y && apt-get upgrade -y
apt-get install -y docker.io docker-compose
```

or
```bash
wget -O - https://raw.githubusercontent.com/tlwt/yoctoDocker/master/scripts/setupBaremetal.sh | bash
```
