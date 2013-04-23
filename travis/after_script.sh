#!/bin/sh

screencapture artifacts/after_script.jpg

travis-artifacts upload --path artifacts --target-path $TRAVIS_REPO_SLUG/$TRAVIS_BUILD_ID/$TRAVIS_JOB_ID
