AfterConfiguration do
  Device.setup
end

at_exit do
  Device.teardown
end

