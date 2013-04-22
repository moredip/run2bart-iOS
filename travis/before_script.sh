xcodebuild -list -workspace Run2Bart/Run2Bart.xcworkspace

brew install ios-sim
IOS_SIM_DIR=`brew info ios-sim | sed -n '3 p' | awk '{print $1}'`
mkdir bin
cp $IOS_SIM_DIR/bin/ios-sim ./bin/ios-sim

gem install travis-artifacts
export TRAVIS_ARTIFACT_DIR=`pwd`/artifacts
mkdir -p $TRAVIS_ARTIFACT_DIR

rake ci:start-recording

screencapture $TRAVIS_ARTIFACT_DIR/before_script.jpg
