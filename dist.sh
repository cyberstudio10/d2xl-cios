#!/bin/bash

# Copyright (C) 2020 Leseratte
# Copyright (C) 2022 cyberstudio

# This bash script is running inside the Docker container
# to actually compile the cIOS. It first creates the
# stripios binary, then runs the maked2x script, while
# including the git commit timestamp in the version string.

# See wiki, this is needed to be able to compile outside of Github environment.
cd /docker-mountpoint || /bin/true

cd stripios
g++ main.cpp -o stripios
cp stripios ../source/stripios
cd ..
timestamp=$(git log -1 --pretty=%ct)
echo Timestamp is $timestamp
export SOURCE_DATE_EPOCH=$timestamp 
export D2XL_VER_COMPILE="v9-$(git log -1 --format=%cd --date=format:%Y%m%d%H%M)"
./maked2x.sh 9 $(git log -1 --format=%cd --date=format:%Y%m%d%H%M)

