#!/bin/sh

screencapture artifacts/after_script_a.jpg

rake ci:stop-recording
rake ci:save-recording["full-travis-run"]

sleep 10

mv /tmp/screenies artifacts/screenies

screencapture artifacts/after_script_b.jpg

travis-artifacts upload --path artifacts --target-path $TRAVIS_BUILD_ID/$TRAVIS_JOB_ID
