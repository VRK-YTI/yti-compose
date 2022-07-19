# YTI docker compose tooling and Spring application configurations for setting up the local environment and running all the Y-applications

This repository contains docker-compose file that helps setting up the YTI multi-container environment easily.

## Description

The docker-compose.yml file has the full environment setup. This file uses docker-compose format version 3.

# YTI platform shared configuration

## Spring configuration profiles

For your local development machine it makes sense to add:
`export SPRING_PROFILES_ACTIVE=local`
to your ~/.bashrc or ~/.bash_profile.

 * default
    - Default profile that is inherited by all other profiles.
 * local
    - For IDE and other local use.
 * docker
    - For use by docker-compose.

## Prerequisities

### Java 11

Install Java JDK 11 (OpenJdk or Oracle)

### Gradle

Install gradle (Tested with 6.8.1)

### Maven

Install maven (Tested with 3.6.3)

### Docker

Install docker

If your OS variant does not contain docker-compose, it needs to be installed separately.

Docker defaults to 2 GB memory, this needs to be changed to a minumum of 4++ GB to avoid OOM issues and containers crashing. You do not need to run all the containers at once, and can run for example only one single selected application.

## Setting up the environment

### Setting up Spring profile environment variable. In Linux and OS X it can be set permanently in either .bashrc or .bash_profile file.
```
export SPRING_PROFILES_ACTIVE=local
```

### Cloning required repositories

Clone required repos manually or using [bootstrap script](https://github.com/VRK-YTI/yti-compose/blob/master/src/script/bootstrap.sh):

```
sudo yti-compose/src/script/bootstrap.sh master
```
 
Script clones all of the required repos to the current directory under build.master folder

### Building components using command line

Each component includes build.sh script which builds the component. Run builds by [setup script](https://github.com/VRK-YTI/yti-compose/blob/master/src/script/setup.sh):

```
sudo yti-compose/src/script/setup.sh
```

Script runs all individual build.sh scripts and publishes local dependecies. Alternatively see **Manual building**.

### Setting up the database for local development and testing

Run in yti-compose directory:

```
sudo chmod -R 777 /data/logs
sudo docker-compose up -d yti-groupmanagement
sudo src/script/init-admin.db
```

Sets permissions for postgres and elasticsearch to write logs in /data/logs. Lastly running init-admin.sh will add one dummy admin user and organization to the database. 
If you are using Mac (Catalina or newer), note that root volume is read only and you have to create [a synthetic firmlink](https://derflounder.wordpress.com/2020/01/18/creating-root-level-directories-and-symbolic-links-on-macos-catalina/)

## Storing data in development

As default, the content you create in local environment is stored inside the container. That is, if you remove/recreate the container, all the data will be lost. If you want to store the data in your local machine, add volume mapping:

``` 
# yti-fuseki
volumes:
   - /data/fuseki:/fuseki/databases

# yti-postgres
volumes:
   - /data/postgres:/var/lib/postgresql
```

## Running services

### Running individual services in backround

Services should be started individually using: 

```
docker-compose up -d <service_name>

docker-compose up -d yti-datamodel-ui
docker-compose up -d yti-terminology-ui
docker-compose up -d yti-codelist-ui
docker-compose up -d yti-comments-ui
```

See service dependencies in docker-compose.yml 

### Looking at service logs for a specific service
```
docker logs --tail=200 -f "container_name_or_id"
```

### Docker process listing

Active processes
```
docker ps
```

All processes
```
docker ps -a
```

## Manual building

Components can (and sometimes should) be built and published manually. Each component has build.sh script that builds the component. Here are some examples how to build components manually: 

### Common components 
First install common libraries to local maven repository. Check required version from pom.xml / build.gradle files

```
cat */build.gradle | grep "yti-spring-security"
cat */pom.xml | grep "yti-spring-security" -A1
```

#### YTI Spring Security

```
cd yti-spring-security
git checkout tags/{{latest tag}}
./gradlew publishToMavenLocal
cd ..
```

#### YTI Spring Migration
```
cd yti-spring-migration
git checkout tags/{{latest tag}}
./gradlew publishToMavenLocal
cd ..
```

#### Codelist common model
```
cd yti-codelist-common-model
./build.sh
cd ..
```

### Java docker base image
```
cd yti-docker-java-base
./build.sh
cd ..
```

### Other components

### YTI ActiveMQ

```
cd yti-activemq
./build.sh
cd ..
```

#### Codelist

#### Codelist Public API Service
```
cd yti-codelist-public-api-service
./build.sh
cd ..
```

#### Codelist Content Intake Service
```
cd yti-codelist-content-intake-service
./build.sh
cd ..
```

#### Codelist UI
```
cd yti-codelist-ui
./build.sh
cd ..
```

### Terminology

#### Terminology Termed API
```
# Use forked termed-api repository
cd termed-api
./build.sh
cd ..
```

#### Terminology API
```
cd yti-terminology-api
./build.sh
cd ..
```

#### Terminology UI
```
cd yti-terminology-ui
./build.sh
cd ..
```

### Datamodel

#### Datamodel API
```
cd yti-datamodel-api
./build.sh
cd ..
```

### Datamodel UI
```
cd yti-datamodel-ui
./build.sh
cd ..
```

#### Datamodel Fuseki
```
cd yti-fuseki
./build.sh
cd ..
```

### Groupmanagement

#### Groupmanagement API + UI
```
cd yti-groupmanangement
./build.sh
cd ..
```

### Comments

#### Comments API
```
cd yti-comments-api
./build.sh
cd ..
```

### Comments UI
```
cd yti-comments-ui
./build.sh
cd ..
```

### Messaging API
```
cd yti-messaging-api
./build.sh
cd ..
```

## Setting up the database for CLS applications
```
cd yti-postgres
./build.sh
cd ..
cd yti-compose
docker-compose up -d yti-postgres
```
