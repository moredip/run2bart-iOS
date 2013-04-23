require 'pathname'

ROOT_DIR = Pathname.new(__FILE__) + ".." + ".."
ARTIFACTS_DIR = ROOT_DIR + "artifacts"
PROJECT_DIR = ROOT_DIR + "Run2Bart"

task :ci => ['clear-artifacts','ci:build','unit-tests']

namespace :ci do
  def move_into_artifacts( src )
    FileUtils.mv( src, ARTIFACTS_DIR.to_s )
  end

  task "clear-artifacts" do
    ARTIFACTS_DIR.rm_rf
    ARTIFACTS_DIR.mkpath
  end

  task :build => ["xcode:sim-debug:cleanbuild"] do
    move_into_artifacts( Pathname.glob(PROJECT_DIR+'build'+'Debug-iphonesimulator'+"*.app") )
  end
end
