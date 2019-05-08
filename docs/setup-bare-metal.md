# How to setup bare metal

a bare metal build system only requires an up-to-date ubuntu with docker & docker-compose installed.
This can be achieved by executing these or similar commands:

```bash
apt-get update -y && apt-get upgrade -y
apt-get install -y docker.io docker-compose
```

## a local image build
In case you dont want to rely on the pre-build image, you can build your own docker image by cloning the repository and starting the build process.

```bash
git clone https://github.com/tlwt/yoctoDocker
cd yoctoDocker
docker-compose up &
```
