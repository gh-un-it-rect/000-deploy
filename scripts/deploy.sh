#!/bin/bash

DEFAULT_INFO=$(curl 'https://api.github.com/repos/gh-un-it-rect/000-deploy)
DEFAULT_BRANCH=$(echo $DEFAULT_INFO | jq '.default_branch' | tr -d \")
DEFAULT_FULLNAME=$(echo $DEFAULT_INFO | jq '.full_name' | tr -d \")
DEFAULT_UPDATED=$(echo $DEFAULT_INFO | jq '.updated_at' | tr -d \")
DEFAULT_CREATED=$(echo $DEFAULT_INFO | jq '.created_at' | tr -d \")
DEFAULT_PUSHED=$(echo $DEFAULT_INFO | jq '.pushed_at' | tr -d \")
 
echo " ------- DEFAULTS -------"
echo "branch: ${DEFAULT_BRANCH}"
echo "fullname: ${DEFAULT_FULLNAME}"
echo "updated_at: ${DEFAULT_UPDATED}"
echo "created_at: ${DEFAULT_CREATED}"
echo "pushed_at: ${DEFAULT_PUSHED}"
echo " -------          -------"

if [ "$TRAVIS_BRANCH" = "master" ]; then
  echo "This branch is the 'master' branch"
else
  echo "This branch is the ${TRAVIS_BRANCH} branch" 
fi
 
echo "param: "$1
