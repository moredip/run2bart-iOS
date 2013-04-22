require 'rubygems'
require 'xcodebuild'

require_relative 'travis/rake_tasks'

namespace 'xcode' do

  XcodeBuild::Tasks::BuildTask.new('sim-debug') do |t|
    t.invoke_from_within = './Run2Bart'
    t.configuration = "Debug"
    t.sdk = "iphonesimulator"
    t.formatter = XcodeBuild::Formatters::ProgressFormatter.new
  end

  XcodeBuild::Tasks::BuildTask.new('unit-tests') do |t|
    t.invoke_from_within = './Run2Bart'
    t.workspace = "Run2Bart.xcworkspace"
    t.configuration = "Debug"
    t.sdk = "iphonesimulator"
    t.scheme = 'CommandLineTests'
    t.xcconfig = 'command-line-tests.xcconfig'
  end
end

task 'quit-simulator' do
  sh %Q|osascript -e 'tell app "iPhone Simulator" to quit'|
end

desc "run all application unit tests"
task 'unit-tests' => ['quit-simulator','xcode:sim-debug:cleanbuild','xcode:unit-tests:build']

task :default => "xcode:sim-debug:build"

