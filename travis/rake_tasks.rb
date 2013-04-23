require 'pathname'

task :ci => ['clear-artifacts','ci:build','unit-tests','ci:frank']

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
  
end

