require_relative "../../ruby-server/dwmb"

APP_PORT = 9999
FAKE_BART_SERVER_BASE_URL = "http://localhost:#{APP_PORT}/"

$app = Sinatra::Application

$app_thread = Thread.fork do
  Rack::Server.start( :app => $app, :Port => APP_PORT, :AccessLog => [] )
end
