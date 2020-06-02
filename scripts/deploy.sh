#!/bin/bash

DEFAULT_BRANCH=$(curl 'https://api.github.com/repos/gh-un-it-rect/000-deploy' | jq '.default_branch' | tr -d \")
echo "Default branch: ${DEFAULT_BRANCH}"

if [ "$TRAVIS_BRANCH" = "master" ]; then
  echo "This branch is the 'master' branch"
else
  echo "This branch is the ${TRAVIS_BRANCH} branch" 
fi
 
