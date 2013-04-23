require 'rubygems'
require 'pathname'
require 'cucumber/rake/task'

require 'xcodebuild'

ROOT_DIR = Pathname.new(__FILE__) + ".."
PROJECT_DIR = ROOT_DIR + "Run2Bart"
ARTIFACTS_DIR = ROOT_DIR + "artifacts"

def move_into_artifacts( src )
  ARTIFACTS_DIR.mkpath unless ARTIFACTS_DIR.exist?
  FileUtils.mv( src, ARTIFACTS_DIR.to_s )
end

task "clear-artifacts" do
  ARTIFACTS_DIR.rmtree
end

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

namespace :frank do
  desc "build a Frankified version of the app for testing purposes"
  task 'build' do
    sh %Q|(cd #{PROJECT_DIR} && frank build)|
  end

  Cucumber::Rake::Task.new(:test, 'Run Frank acceptance tests, generating HTML report as a CI artifact') do |t|
    t.cucumber_opts = %Q|#{ROOT_DIR+'features'} --format pretty --format html --out #{ARTIFACTS_DIR+'frank_results.html'}|
  end
end

desc "build and run frank tests"
task :frank => ["frank:build","frank:test"]


namespace :shenzhen do
  task :build do
    sh %Q|(cd #{PROJECT_DIR} && ipa build -s Run2Bart)|
  end
  
  task :distribute, [:build_name, :build_url] => [:build] do |task,args|
    build_notes = "## Machine-generated build\n"
    if (name = args[:build_name]) && (url = args[:build_url])
      build_notes << "This release was pooped out of build [#{name}](#{url})"
    else
      build_notes << "This release was manually triggered from a developer machine"
    end

    sh %Q|(cd #{PROJECT_DIR} && ipa distribute:hockeyapp --token "$HOCKEY_APP_TOKEN" --markdown -m '#{build_notes}')|
  end
end

task 'quit-simulator' do
  sh %Q|osascript -e 'tell app "iPhone Simulator" to quit'|
end

desc "run all application unit tests"
task 'unit-tests' => ['quit-simulator','xcode:sim-debug:cleanbuild','xcode:unit-tests:build']

task :default => "unit-tests"

