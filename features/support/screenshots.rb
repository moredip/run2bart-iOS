require 'pathname'

if ENV.has_key? 'PER_STEP_CAPTURE_DIR'
  AfterStep do |scenario|
    capture_dir = Pathname.new( ENV['PER_STEP_CAPTURE_DIR'] )
    capture_dir.mkpath unless capture_dir.exist?
    capture_path = (capture_dir + Time.now.to_f.to_s.gsub('.','-')).sub_ext('.jpg')

    %x|screencapture #{capture_path}|
  end
end

