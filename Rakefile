require 'rubygems'
require 'xcodebuild'

XcodeBuild::Tasks::BuildTask.new do |t|
  t.invoke_from_within = './Run2Bart'
  t.configuration = "Debug"
  t.sdk = "iphonesimulator"
end

task :default => "xcode:build"
