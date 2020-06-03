#!/bin/bash

function __profiler__ {
   DEFAULT_INFO=$(curl 'https://api.github.com/repos/gh-un-it-rect/000-deploy')
   #DEFAULT_BRANCH=$(echo $DEFAULT_INFO | jq '.default_branch' | tr -d \")
   #DEFAULT_FULLNAME=$(echo $DEFAULT_INFO | jq '.full_name' | tr -d \")
   #DEFAULT_UPDATED=$(echo $DEFAULT_INFO | jq '.updated_at' | tr -d \")
   #DEFAULT_CREATED=$(echo $DEFAULT_INFO | jq '.created_at' | tr -d \")
   #DEFAULT_PUSHED=$(echo $DEFAULT_INFO | jq '.pushed_at' | tr -d \")

   echo ""
   echo -e " \e[42;1m ------- DEFAULTS -------"
   echo "info: ${DEFAULT_INFO}"
   #echo "branch: ${DEFAULT_BRANCH}"
   #echo "fullname: ${DEFAULT_FULLNAME}"
   #echo "updated_at: ${DEFAULT_UPDATED}"
   #echo "created_at: ${DEFAULT_CREATED}"
   #echo "pushed_at: ${DEFAULT_PUSHED}"
   echo " -------          -------"

   echo ""
   
   echo -e " \e[42;1m ------- TRAVIS -------"
   echo "token: $__TOKEN_GITHUB__"
   echo "arg: $__PREVIEW__" 
   echo "arg: $__BODY_OK__"
   echo "arg: $__BODY_KO__"
   echo "arg: $__ORG_DEPLOY__"
   echo "arg: $__REPO_DEPLOY__"
   echo "arg: $__JSON__"
   echo "arg: $__SSHKEY__"
   echo "branch: $TRAVIS_BRANCH"
   echo " -------     -------"
   
   echo "" 

   echo -e " \e[42;1m ------- SSH -------"
   eval "$(ssh-agent -s)"
  #echo -e $__SSHKEY__ > deploy_key.pem
  #cat  deploy_key.pem
  #echo -ne '\n' | chmod 600 deploy_key.pem 
  #echo -ne '\n' | ssh-add deploy_key.pem
  echo -ne '\n'
  echo -ne '\n'
   echo " -------     -------"
}

function __execute__ {
   if [ "$TRAVIS_BRANCH" = "master" ]; then
     echo "This branch is the master branch"
     
     echo -e " \e[42m curl PATCH -i -H $__PREVIEW__ -H $__JSON__ -H Authorization: token $__TOKEN_GITHUB__ -d $__BODY_OK__ https://api.github.com/repos/$__ORG_DEPLOY__/$__REPO_DEPLOY__"
     curl -i -H "$__PREVIEW__" -H "$__JSON__" -H "Authorization: token $__TOKEN_GITHUB__" -d "$__BODY_OK__" https://api.github.com/repos/$__ORG_DEPLOY__/$__REPO_DEPLOY__
     
      rm -Rf .git
      git config --global user.name "Travis CI"
      git config --global user.email "travis@travis-ci.org"
      
      git init 
      echo "hola!" > file.txt
      git add -A
      git commit -m "Reset Repo"

      git remote add origin https://$__TOKEN_GITHUB__@github.com/$__ORG_DEPLOY__/$__REPO_DEPLOY__.git > /dev/null 2>&1
     // git push git@github.com:gh-un-it-rect/000-deploy-find-errors.git master
      git push --quiet --set-upstream origin master 

     echo -e "\e[42m curl PATCH -i -H $__PREVIEW__ -H $__JSON__ -H Authorization: token $__TOKEN_GITHUB__ -d $__BODY_KO__ https://api.github.com/repos/$__ORG_DEPLOY__/$__REPO_DEPLOY__"
     curl -i -H "$__PREVIEW__" -H "$__JSON__" -H "Authorization: token $__TOKEN_GITHUB__" -d "$__BODY_KO__" https://api.github.com/repos/$__ORG_DEPLOY__/$__REPO_DEPLOY__
     
     
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
