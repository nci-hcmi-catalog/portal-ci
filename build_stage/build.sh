#/bin/bash
echo "Building $2 package."
export tag_version=`git tag -l --points-at HEAD`
rm $2.tar 2>/dev/null
tar --exclude='./'$1 --exclude='./.git' --exclude='./Jenkinsfile' -cvf $2.tar ./$2
