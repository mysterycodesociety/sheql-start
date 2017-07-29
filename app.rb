# require gems
require 'sinatra'
require 'sinatra/activerecord'
require 'pry'
require 'logger'
require 'google/api_client/client_secrets'
require 'google/apis/oauth2_v2'

# require models
Dir["./models/*.rb"].each {|file| require file }

# require routes
Dir["./routes/*.rb"].each {|file| require file }
require "./routes.rb"

enable :sessions

def logger; settings.logger end

configure do
  log_file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  log_file.sync = true
  use Rack::CommonLogger, log_file

  logger = Logger.new(log_file)
  logger.level = Logger::DEBUG

  Google::Apis::ClientOptions.default.application_name = 'SheQL'
  Google::Apis::ClientOptions.default.application_version = '1.0.0'

  client_secrets = Google::APIClient::ClientSecrets.load
  authorization = client_secrets.to_authorization
  authorization.scope = 'openid email profile'

  set :no_auth_neededs, ['/login', '/authenticate', '/authenticated']

  set :authorization, authorization
  set :logger, logger
end

def user_credentials
  # Build a per-request oauth credential based on token stored in session
  # which allows us to use a shared API client.
  @authorization ||= (
    auth = settings.authorization.dup
    auth.redirect_uri = to('/authenticated')
    auth.update_token!(session)
    auth
  )
end

def logged_in?
  !session[:access_token].nil?
end


before do
  unless logged_in? || settings.no_auth_neededs.include?(request.path_info)
    redirect to('/login')
  end
end

after do
  set_user_session
end