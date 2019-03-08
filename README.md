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

Docker installation is necessary, and if your OS variant does not contain docker-compose, it needs to be installed separately.

NOTE:
Docker defaults to 2 GB memory, this needs to be changed to a minumum of 4++ GB to avoid OOM issues and containers crashing. You do not need to run all the containers at once, and can run for example only one single selected application.

## Setting up the environment

### Setting up Spring profile environment variable. In Linux and OS X it can be set permanently in either .bashrc or .bash_profile file.
```
export SPRING_PROFILES_ACTIVE=local
```

### Building components using command line

#### Generic artifacts

#### YTI Spring Security

```
cd yti-spring-security
git checkout tags/v.0.1.2
./gradlew publishToMavenLocal
cd ..
```

### YTI Spring Migration
```
cd yti-spring-migration
./gradlew publishToMavenLocal
cd ..
```

#### Codelist common model
```
cd yti-codelist-common-model
./build.sh
cd ..
```

#### Java docker base image
```
cd yti-docker-java-base
./build.sh alpine
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

#### Codelist ElasticSearch
```
cd yti-codelist-elasticsearch
./build.sh
cd ..
```

#### Terminology

#### Terminology Termed API
```
cd yti-terminology-termed-api
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

#### Datamodel

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

#### Groupmanagement

#### Groupmanagement API + UI
```
cd yti-groupmanangement
./build.sh
cd ..
```

#### Comments

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

#### Setting up the database for CLS applications
```
cd yti-postgres
./build.sh
cd ..
cd yti-codelist-compose
docker-compose up -d yti-postgres
```

#### Running whole service via docker-compose, logging goes to system out
```
docker-compose up
```

#### Running individual services in backround
```
docker-compose up -d <service_name>
```

#### Looking at service logs for a specific service
```
docker logs --tail=200 -f "container_name_or_id"
```

#### Docker process listing

Active processes
```
docker ps
```

All processes
```
docker ps -a
```
