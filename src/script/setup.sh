#!/bin/bash
BUILD_BASE=$PWD/build

#YTI common libraries
GENERIC_COMPONENTS="yti-spring-security
		    yti-spring-migration"
#YTI service components
COMPONENTS="yti-docker-java-base
            yti-postgres
            yti-groupmanagement
            yti-codelist-common-model
	    yti-codelist-public-api-service
	    yti-codelist-content-intake-service
            yti-codelist-ui
            yti-terminology-termed-docker
            yti-terminology-api
            yti-terminology-ui
	    yti-fuseki
	    yti-datamodel-api
            yti-datamodel-ui
            yti-comments-api
            yti-comments-ui"

publish_component () {
    pushd . >/dev/null
    echo "publish component:$1"
    echo "--------------------------"
    cd $BUILD_BASE/$1/
    echo $PWD
    ./gradlew publishToMavenLocal
    echo "DONE $1"
   popd
}

build_component () {
    pushd . >/dev/null
    echo "--------------------------" 
    echo "build component:$1 option:$2"
    echo "--------------------------" 
    cd $BUILD_BASE/$1/
    ./build.sh $2
    popd
}

echo "Starting development environment Setup" 
#build generic artifacts
for component in $GENERIC_COMPONENTS
do
    echo "Handling $component"
    publish_component  $component
done
echo "Base libraries build"
#Build release and YTI containers
for component in $COMPONENTS
do
    echo "Handling $component"
    build_component  $component
done
echo "YTI build done" 
