#!/bin/sh

# After building the image, you can run yastasoti from within it like:
#
# docker run --user $(id -u):$(id -g) -i -t -v "${PWD}:/usr/src/app/" yastasoti \
#        yastasoti links.json --archive-to=./
#

rm -rf script/*.pyc script/__pycache__
docker container prune
docker rmi catseye/yastasoti:0.4
docker rmi yastasoti
docker build -t yastasoti .
docker tag yastasoti catseye/yastasoti:0.4
