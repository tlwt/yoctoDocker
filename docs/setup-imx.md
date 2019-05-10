# Setup i.MX
1. The release section contains a zip file with an `Distro` (e.g. fsl-imx-x11)
 `Machine` (e.g. imx6ulevkand) information and a date & time when the image was build. Download the zip file in the section.
2. Within the ZIP file which is currently (2019-05-01) about 200 MB large you'll find the image file ending on `rootfs.sdcard.bz2` (the date and distro will vary.) e.g.```core-image-base-imx6ulevk-20190429085504.rootfs.sdcard.bz2```
3. Once you downloaded the image you need to execute the following commands:
```bash
bunzip2 -dk -f <image_name>.sdcard.bz2
sudo dd if=<image name>.sdcard  of=/dev/sd<partition> bs=1M conv=fsync
```

From experience, the sd card device usually shows up as /dev/mmcblk0, at least
in modern Ubuntu.
