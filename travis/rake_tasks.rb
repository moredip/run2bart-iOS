require 'pathname'

task :ci => ['clear-artifacts','ci:build','unit-tests','ci:frank','ci:distribute']

namespace :ci do
  
  task :build => ["xcode:sim-debug:cleanbuild"] do
    move_into_artifacts( Pathname.glob(PROJECT_DIR+'build'+'Debug-iphonesimulator'+"*.app") )
  end

  task "frank-setup" do
    ENV['PER_STEP_CAPTURE_DIR'] = (ARTIFACTS_DIR+'per_step_screenies').to_s
  end

  task "frank" => ["ci:frank-setup","frank:build","frank:test"] do
    move_into_artifacts( Pathname.glob(PROJECT_DIR+'Frank'+'frankified_build'+"Frankified.app") )
  end

  task "distribute" do
    build_name = "Travis Build #{ENV['TRAVIS_BUILD_NUMBER']}" 
    build_url = ENV['TRAVIS_BUILD_URL']
    Task["shenzhen:distribute"].invoke(build_name,build_url)
  end
  
end

