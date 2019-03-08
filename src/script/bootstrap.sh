#!/bin/bash
#Where to fetch sources
BUILD_BASE=$PWD/build
#Component-list
components="yti-spring-security
yti-spring-migration
yti-codelist-common-model
yti-docker-java-base
yti-codelist-public-api-service
yti-codelist-content-intake-service
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

#clone given repository from git
clone_component_from_git () {
    `git clone $1$2.git`
}

#Main
echo Clone repositories
mkdir -p $BUILD_BASE
cd $BUILD_BASE
echo YTI
for currentComponent in $components
do
    clone_component_from_git $YTI_REPO $currentComponent
done
echo TERMED
for currentComponent in $termedComponents
do
    clone_component_from_git $TERMED_REPO $currentComponent
done
cd ..
