#!/bin/sh

curl -u ${CIRCLE_API_TOKEN}: \
     -d build_parameters[CIRCLE_JOB]=build \
     https://circleci.com/api/v1.1/project/github/snaga/postgres-dev/tree/master

