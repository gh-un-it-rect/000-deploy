#!/bin/bash

function __profiler__ {
   DEFAULT_INFO=$(curl 'https://api.github.com/repos/gh-un-it-rect/000-deploy')
   #DEFAULT_BRANCH=$(echo $DEFAULT_INFO | jq '.default_branch' | tr -d \")
   #DEFAULT_FULLNAME=$(echo $DEFAULT_INFO | jq '.full_name' | tr -d \")
   #DEFAULT_UPDATED=$(echo $DEFAULT_INFO | jq '.updated_at' | tr -d \")
   #DEFAULT_CREATED=$(echo $DEFAULT_INFO | jq '.created_at' | tr -d \")
   #DEFAULT_PUSHED=$(echo $DEFAULT_INFO | jq '.pushed_at' | tr -d \")

   echo " ------- DEFAULTS -------"
   echo "info: ${DEFAULT_INFO}"
   #echo "branch: ${DEFAULT_BRANCH}"
   #echo "fullname: ${DEFAULT_FULLNAME}"
   #echo "updated_at: ${DEFAULT_UPDATED}"
   #echo "created_at: ${DEFAULT_CREATED}"
   #echo "pushed_at: ${DEFAULT_PUSHED}"
   echo " -------          -------"

   echo ""

   echo " ------- SSH -------"
   eval "$(ssh-agent -s)"
   echo -e $SSHKEY
   echo " -------     -------"
   
   echo ""
   
   echo " ------- TRAVIS -------"
   echo "token: $__TOKEN_GITHUB__" 
   echo "branch: $TRAVIS_BRANCH"
   echo " -------     -------"
  
}

function __execute__ {
   if [ "$TRAVIS_BRANCH" = "master" ]; then
     echo "This branch is the master branch"
     quit 0
   else
     echo -e "\e[31mPor favor recuerde que solo pueden deployar en rama Master\e[0m"
     echo -e "\e[31mhttps://github.com/gh-un-it-rect/000-deploy/settings/branches\e[0m"
     quit 1
   fi
}

function quit {
   echo "exit "$1
   exit $1
}

function __main__ {
  __profiler__
  __execute__
}

__main__
