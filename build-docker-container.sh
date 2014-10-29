#!/bin/bash
if [ -z "$GO_PIPELINE_LABEL" ] ; then
    # probably manual testing, lets get a random enough number
    GO_PIPELINE_LABEL=`mktemp -u | cut -d '.' -f 2 | tr [:upper:] [:lower:]`
    echo $GO_PIPELINE_LABEL
fi

if [ -z "$DOCKERREGISTRY_HOST" ] ; then
    DOCKERREGISTRY_HOST="${DOCKERREGISTRY_PORT_5000_TCP_ADDR}"
fi

docker build -t "doodleshop/$GO_PIPELINE_LABEL" .
docker tag doodleshop/$GO_PIPELINE_LABEL $DOCKERREGISTRY_HOST:5000/doodleshop/$GO_PIPELINE_LABEL
docker push $DOCKERREGISTRY_HOST:5000/doodleshop/$GO_PIPELINE_LABEL
