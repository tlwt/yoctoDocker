## environment variables

the following environmental variables need to be set in order for the build process to work:

Your git information:
```
- GIT_EMAIL=witt@consider-it.de
- GIT_NAME=Till Witt
```

The distro, machine and image setting you want to be build:

```
- Y_MACHINE=imx6ulevk
- Y_DISTRO=fsl-imx-x11
- Y_IMAGE=core-image-base
```

In case you want to publish your own releases on GITHUB you need an oauth token from GITHUB. You want to hide this using secrets in your build process.
```
- GITHUB_TOKEN=<secret>
```

For debugging purpose you want to use the following variables to speed up the entire process by skipping certain steps.

```
- disable_sync=1
- disable_setup=1
- disable_bake=1
```
