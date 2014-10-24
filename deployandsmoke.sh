#!/bin/bash
# Deploy and run smoketest on doodle
INSTANS=${DOODLE_ENV}
VERSION=${GO_PIPELINE_LABEL}
PORTPREFIX=$1
PORT=8080

set -e
# Kill old instans
echo running sudo docker rm -f doodleshop-${INSTANS}
sudo docker rm -f doodleshop-${INSTANS} || /bin/true

# Download newly built version
echo Pulling new doodleshop docker image
sudo docker pull localhost:5000/doodleshop:$VERSION

# Start a new one
echo running sudo docker run -d -e "DOODLE_ENV=${DOODLE_ENV}" --name doodleshop-${INSTANS} -p ${PORTPREFIX}${PORT}:${PORT} doodleshop:$VERSION
sudo docker run -d -e "DOODLE_ENV=${DOODLE_ENV}" --name doodleshop-${INSTANS} -p ${PORTPREFIX}${PORT}:${PORT} doodleshop:$VERSION
# Sleep some time before checking that it's working
timeout 3m bash runsmoketestuntilkilled.sh

