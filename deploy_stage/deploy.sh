#!/bin/bash
function checkStatus() {
    if [ $1 -ne 0 ]; then
        exit 1
    fi
}

# create install directory if it doesn't exist yet
mkdir -p install
cd install
checkStatus $?
# unzip deployment package
tar -xvf ../deploy/$2/portal.tar
checkStatus $?
#build
make
checkStatus $?
# build production build of ui
cd ../
cd install

# export REACT env variables
export $3 $4 $5 $6
yarn netlify
checkStatus $?

# start api
cd api
pm2 startOrRestart pm2.config.js --env $1
checkStatus $?
