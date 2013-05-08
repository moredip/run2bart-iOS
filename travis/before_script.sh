#!/bin/sh

env

xcodebuild -list -workspace Run2Bart/Run2Bart.xcworkspace

brew update
brew install xctool ios-sim
IOS_SIM_DIR=`brew info ios-sim | sed -n '3 p' | awk '{print $1}'`
mkdir bin
cp $IOS_SIM_DIR/bin/ios-sim ./bin/ios-sim

gem install travis-artifacts
mkdir -p $TRAVIS_ARTIFACTS_DIR

screencapture $TRAVIS_ARTIFACTS_DIR/before_script.jpg
