#!/bin/bash
mkdir -p install
cd install
tar -xvf ../deploy/$2/portal.tar
make
cd ../
cd install/api
pm2 startOrRestart pm2.config.js --env $1