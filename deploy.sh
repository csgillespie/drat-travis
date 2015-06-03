#!/bin/bash

set -o errexit -o nounset

addToDrat(){
  PKG_REPO=$PWD

  cd ..; mkdir drat; cd drat

  ## Set up Repo parameters
  git init
  git config user.name "Colin Gillespie"
  git config user.email "csgillespie@gmail.com"
  git config --global push.default simple

  ## Get drat repo
  git remote add upstream "https://$GH_TOKEN@github.com/csgillespie/drat.git"
  git fetch upstream
  git checkout gh-pages

  Rscript -e "drat::insertPackage('$PKG_REPO/$PKG_TARBALL', \
    repodir = '.', \
    commit='Travis update: build $TRAVIS_BUILD_NUMBER')"
  git push

}

addToDrat

## Other options:
## Only add if the commit is tagged: so something like:
#if [ $TRAVIS_TAG ] ; then
#   addToDrat
#fi
##but will need to edit .travis.yml since $TRAVIS_BRANCH will now equal $TRAVIS_TAG

