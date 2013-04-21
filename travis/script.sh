#!/bin/sh

brew install ios-sim
IOS_SIM_DIR=`brew info ios-sim | sed -n '3 p' | awk '{print $1}'`
cp $IOS_SIM_DIR/bin/ios-sim ./
ls -l .

rake ci
