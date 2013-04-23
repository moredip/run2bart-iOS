require 'pathname'

task :ci => ['clear-artifacts','ci:build','unit-tests','ci:frank']

namespace :ci do

  task :build => ["xcode:sim-debug:cleanbuild"] do
    move_into_artifacts( Pathname.glob(PROJECT_DIR+'build'+'Debug-iphonesimulator'+"*.app") )
  end

  task "frank" => ["frank:build","frank:test"] do
    move_into_artifacts( Pathname.glob(PROJECT_DIR+'Frank'+'frankified_build'+"Frankified.app") )
  end
end

