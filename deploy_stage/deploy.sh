#!/bin/bash
function checkStatus() {
    if [ $1 -ne 0 ]; then
        exit 1
    fi
}

echo "Running as :" $USER
echo "Running with Parameters :" $1 $2 $3
# create logs directory if it doesn't exist yet
mkdir -p logs

# create install directory if it doesn't exist yet
mkdir -p install
cd install
checkStatus $?

# unzip deployment package
tar -xvf ../deploy/$2/$3.tar
checkStatus $?

#build
cd $3
yarn
checkStatus $?

# start cms
if [ $3 == 'cms' ]; then
    (cd variant-migrations; yarn migrate-mongo up)
    pm2 startOrRestart pm2.config.js --env $1
fi

# start api
if [ $3 == 'api' ]; then
    pm2 startOrRestart pm2.config.js --env $1
fi

# build production build of ui
if [ $3 == 'ui' ]; then
    yarn build
fi
checkStatus $?
