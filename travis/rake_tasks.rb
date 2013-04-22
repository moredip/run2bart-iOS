require 'pathname'
task :ci => ['unit-tests']

namespace :ci do
  task 'start-recording' do
    %x{osascript<<APPLESCRIPT
      tell application "QuickTime Player"
      set sr to new screen recording
        tell sr to start
      end tell
    APPLESCRIPT}
  end
  task 'stop-recording' do
    %x{osascript<<APPLESCRIPT
      tell application "QuickTime Player"
        set sr to (document 1)
        tell sr to stop
      end tell
    APPLESCRIPT}  
  end

  task 'save-recording', :filename do |t,args|
    output_filename = args[:filename] || 'screen-recording'
    output_dir = Pathname.new( "/tmp/screenies" )
    output_dir.mkpath

    output_path = output_dir + output_filename
    if output_path.extname.empty?
      output_path = output_path.sub_ext('.m4v')
    end

    %x{osascript<<APPLESCRIPT
      tell application "QuickTime Player"
        set f to "#{output_path}"
          tell last item of documents
            export in f using settings preset "480p"
            close
          end tell
        end tell
    APPLESCRIPT}  
  end
end
