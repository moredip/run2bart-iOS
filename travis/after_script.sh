#!/bin/sh

rake ci:stop-recording
rake ci:save-recording["travis-build-$TRAVIS_BUILD_NUMBER"]

sleep 10

ls -l /tmp/screenies/
