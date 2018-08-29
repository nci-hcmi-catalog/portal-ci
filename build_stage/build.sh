#/bin/bash
echo "Building $2 package."
export tag_version=`git tag -l --points-at HEAD`
rm $2.tar 2>/dev/null

if [ $2 = 'ui' ]; then
  tar --exclude='./'$1 --exclude='./.git' --exclude='./Jenkinsfile' --exclude='./docs' --exclude='./data_model' --exclude='./*.tar' --exclude='./README.md' --exclude='./README.md' -cvf $2.tar .
else
  tar --exclude='./'$1 --exclude='./.git' --exclude='./Jenkinsfile' -cvf $2.tar ./$2
fi
