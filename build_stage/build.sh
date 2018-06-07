#/bin/bash
export tag_version=`git tag -l --points-at HEAD`
rm portal.tar 2>/dev/null
tar --exclude='./'$1 --exclude='./.git' --exclude='./Jenkinsfile' -cvf portal.tar .
