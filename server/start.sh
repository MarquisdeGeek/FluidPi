#!/bin/bash

socat TCP4-LISTEN:9987,fork EXEC:/home/synth/server/bashttpd  > /dev/null &

