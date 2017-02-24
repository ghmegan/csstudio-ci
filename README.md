# csstudio-ci

This repository contains the documentation and scripts used for the SNS CI server

The server hosts a Nexus 2 artifact manager to cache Maven and P2 artifcats used in our build. 

We also Hudson CI server to generate nightly builds of CSS that we make available on our public facing web server.

## Quickstart to build SNS CSS

```
# ./build-scripts/get_all.sh
# ./build-scripts/make_all.sh
```

## Doc

Documents the steps taken to setup Nexus 2 and Hudson.

## Nexus scripts

Scripts to backup the Nexus config, setup plugins, etc.

## Build Scripts

These are the build scripts for making the SNS CSS product using the Nexus instance.
