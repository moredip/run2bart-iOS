require 'pathname'

task :ci => ['clear-artifacts','unit-tests','ci:frank']

namespace :ci do
  
  task "frank-setup" do
    ENV['PER_STEP_CAPTURE_DIR'] = (ARTIFACTS_DIR+'per_step_screenies').to_s
  end

  task "frank" => ["ci:frank-setup","frank:build","frank:test"] do
    move_into_artifacts( Pathname.glob(PROJECT_DIR+'Frank'+'frankified_build'+"Frankified.app") )
  end

  task "distribute" do
    build_name = "Travis Build #{ENV['TRAVIS_BUILD_NUMBER']}" 
    build_url = ENV['TRAVIS_BUILD_URL']
    Rake::Task["shenzhen:distribute"].invoke(build_name,build_url)
  end
  
end

