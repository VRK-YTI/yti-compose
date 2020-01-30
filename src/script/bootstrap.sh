#!/bin/bash

#common libraries
commonLibs="yti-spring-security
yti-spring-migration"
#Component-list
components="yti-codelist-common-model
yti-docker-java-base
yti-config-server
yti-codelist-public-api-service
yti-codelist-content-intake-service
yti-codelist-ui
yti-terminology-termed-docker
yti-terminology-api
yti-terminology-ui
yti-fuseki
yti-datamodel-api
yti-datamodel-ui
yti-datamodel-database
yti-groupmanagement
yti-comments-api
yti-comments-ui
yti-postgres
"

#yti-fuseki = yti-datamodel-database
termedComponents="termed-api"

YTI_REPO="https://github.com/VRK-YTI/"
TERMED_REPO="https://github.com/THLfi/"

#clone given repository from git with given branch or master
clone_component_from_git () {
        `git clone $1$2.git -b$3`
}

clone_and_publish_components (){
    cd $1
    tags=`git describe --tags $(git rev-list --tags --max-count=2)`
    echo "tags=$tags"
    for tag in $tags
    do
	echo "Get and compile tag $tag"
	`git checkout $tag`
         echo "publish component:$1"
         echo "--------------------------"
         ./gradlew publishToMavenLocal
         echo "DONE $1"
    done
    cd ..
}
#Main
#Where to fetch sources
BRANCH=master
if [ $# -eq 1 ]
  then
      echo "Active branch $1"
      BRANCH=$1
fi
BUILD_BASE=$PWD/build.$BRANCH

echo Clone repositories
mkdir -p $BUILD_BASE
cd $BUILD_BASE
echo "Fetching YTI into the $BUILD_BASE"
echo "Get libraries"
for lib in $commonLibs
do
    echo "Publishing $lib"
    clone_component_from_git $YTI_REPO $lib $BRANCH
    clone_and_publish_components $lib
done
echo "Get components"
for currentComponent in $components
do
    clone_component_from_git $YTI_REPO $currentComponent $BRANCH
done

echo TERMED
for currentComponent in $termedComponents
do
    clone_component_from_git $TERMED_REPO $currentComponent $BRANCH
done
cd ..
