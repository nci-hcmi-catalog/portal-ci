#!/bin/bash

# create install directory if it doesn't exist yet
mkdir -p install
cd install

# unzip deployment package
tar -xvf ../deploy/$2/portal.tar

#build
make

# build production build of ui
cd ../
cd install
yarn netlify

# start api
cd api
pm2 startOrRestart pm2.config.js --env $1