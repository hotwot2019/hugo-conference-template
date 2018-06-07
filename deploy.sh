#!/bin/bash

WEBFOLDER=../hotwot2018.github.io/
DIR=`pwd`

echo -e "\033[0;32mBuild the static site...\033[0m"

# Build the project.
hugo


echo -e "\033[0;32mCopy to target folder...\033[0m"
# Go To Public folder
rsync -arv --delete --exclude={.git,.gitignore,README.md,.DS_Store} public/ $WEBFOLDER


# Add changes to git.
cd $WEBFOLDER
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

echo -e "\033[0;32mPush to remote...\033[0m"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd $DIR
rm -rf public/*

echo -e "\033[0;32mDone.\033[0m"