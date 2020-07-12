# Deprecated 
## This project is moved to [NRCHKB/node-red-contrib-homekit-docker](https://github.com/NRCHKB/node-red-contrib-homekit-docker) and will no longer be maintained.  
## All users are recommended to replace `raymondmm/node-red-homekit` with `nrchkb/node-red-homekit` in your commands/compose file/stack file.

# Node-RED-homekit-docker
[![Greenkeeper badge](https://badges.greenkeeper.io/RaymondMouthaan/node-red-homekit-docker.svg)](https://greenkeeper.io/)
[![Build Status](https://travis-ci.org/RaymondMouthaan/node-red-homekit-docker.svg?branch=master)](https://travis-ci.org/RaymondMouthaan/node-red-homekit-docker)
[![DockerHub Pull](https://img.shields.io/docker/pulls/raymondmm/node-red-homekit.svg)](https://hub.docker.com/r/raymondmm/node-red-homekit/)
[![DockerHub Star](https://img.shields.io/docker/stars/raymondmm/node-red-homekit.svg?maxAge=2592000)](https://hub.docker.com/r/raymondmm/node-red-homekit/)

Node-red-homekit-docker is a Node-RED based project with support for homekit. It is based on the [official Node-RED Docker](https://hub.docker.com/r/nodered/node-red) images with the necessary tools and npm module [node-red-contrib-homekit-bridged](https://www.npmjs.com/package/node-red-contrib-homekit-bridged) installed to run homekit within a docker container. 

## Architecture
Node-red-homekit-docker is supported by manifest list, which means one doesn't need to specify the tag for a specific architecture. Using the image without any tag or the latest tag, will pull the right image for the architecture required.

Currently Node-RED-homekit has support for multiple architectures:
- `amd64`   : based on linux Alpine - for most desktop computer (e.g. x64, x86-64, x86_64)
- `arm32v6` : based on linux Alpine - (i.e. Raspberry Pi 1 & Zero)
- `arm32v7` : based on linux Alpine - (i.e. Raspberry Pi 2, 3, 4)
- `arm64v8` : based on linux Alpine - (i.e. Pine64)

**Note**: Currently there is a bug in Docker's architecture detection that fails for arm32v6 - eg Raspberry Pi Zero or 1. For these devices you currently need to specify the full image tag for arm32v6.

### Quick Start

```shell script
docker run -d --net=host -v <path_on_host>:/data --name=node-red-homekit raymondmm/node-red-homekit
```

Let's dissect that command:

    docker run                  - Run this container.
    -d                          - Run container in background and print container ID.
    --net=host                  - Connect to the host network, which is required to work with homekit.
    -v <path_on_host>:/data     - Persist container data
    --name node-red-homekit     - Give this machine a friendly local name.
    raymondmm/node-red-homekit  - The image to base it.

### Synology

Synology users need to add the environment variable DSM_HOSTNAME.

Click the Environment tab and add a new environment variable named DSM_HOSTNAME. The value of the DSM_HOSTNAME environment variable should exactly match the server name as shown under Synology DSM Control Panel -> Info Center -> Server name, it should contain no spaces or special characters.

```shell script
docker run it --net=host -v <path_on_host>:/data -e DSM_HOSTNAME=<synology_hostname> --name=homekit raymondmm/node-red-homekit:<tag>
```

### Permissions

Since Node-RED 1.0 the container user is `node-red` and has uid `1000` and gid `1000`, make sure your <path_on_host> has the same uid and gid:

Verify command:

```shell script
ls -nal <path_on_host>
```

Modify command:

```shell script
chown -R  1000:1000 <path_on_host>
```

### Node-RED Docker official
For more detailed info refer to the [Node-RED Docker official](https://github.com/node-red/node-red-docker) pages.
