#!/usr/bin/env bash

source ./global_functions.sh

if check_internet_connection ; then
    echo "UP"
else
    echo "DOWN"
fi