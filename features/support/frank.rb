require 'frank-cucumber'

Frank::Cucumber::FrankHelper.use_shelley_from_now_on

APP_BUNDLE_PATH = File.expand_path( '../../../Run2Bart/Frank/frankified_build/Frankified.app', __FILE__ )

$frank = Object.new.extend(Frank::Cucumber::FrankHelper).extend(Frank::Cucumber::Launcher)

module IPhone
  def self.reset
    $frank.launch_app APP_BUNDLE_PATH
    $frank.app_exec( "setApiBaseUrl:", FAKE_BART_SERVER_BASE_URL )
  end

  def self.setup
    # noop
  end

  def self.teardown
    # noop
  end
end

# hardcoded for now
Device = IPhone
