#!/bin/sh

screencapture $TRAVIS_ARTIFACT_DIR/after_script.jpg

rake ci:stop-recording
rake ci:save-recording["full-travis-run"]

sleep 10

mv /tmp/screenies $TRAVIS_ARTIFACT_DIR/screenies

travis-artifacts upload --path $TRAVIS_ARTIFACT_DIR --target-path $TRAVIS_BUILD_ID/$TRAVIS_JOB_ID
