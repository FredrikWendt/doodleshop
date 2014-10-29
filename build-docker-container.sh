#!/bin/bash
if [ -z "$GO_PIPELINE_LABEL" ] ; then
    # probably manual testing, lets get a random enough number
    GO_PIPELINE_LABEL=`mktemp -u | cut -d '.' -f 2 | tr [:upper:] [:lower:]`
    echo $GO_PIPELINE_LABEL
fi

if [ -z "DOCKER_REGISTRY_HOST" ] ; then
    DOCKER_REGISTRY_HOST=docker-registry
fi

docker build -t "doodleshop/$GO_PIPELINE_LABEL" .
docker tag doodleshop/$GO_PIPELINE_LABEL $DOCKER_REGISTRY_HOST:5000/doodleshop/$GO_PIPELINE_LABEL
docker push $DOCKER_REGISTRY_HOST:5000/doodleshop/$GO_PIPELINE_LABEL
