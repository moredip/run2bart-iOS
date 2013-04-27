#!/bin/sh

screencapture $TRAVIS_ARTIFACTS_DIR/after_script.jpg

travis-artifacts upload --root $TRAVIS_ARTIFACTS_DIR --path $TRAVIS_ARTIFACTS_DIR --target-path $TRAVIS_REPO_SLUG/$TRAVIS_BUILD_ID/$TRAVIS_JOB_ID
