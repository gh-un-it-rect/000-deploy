#!/bin/bash

if [ "$TRAVIS_BRANCH" = "master" ]; then
  echo "This branch is the 'master' branch"
else
 echo "This branch is the ${TRAVIS_BRANCH} branch"
 
