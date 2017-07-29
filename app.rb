# require gems
require 'sinatra'
require 'sinatra/activerecord'
require 'pry'
require 'logger'
require 'google/api_client/client_secrets'
require 'google/apis/oauth2_v2'
require 'securerandom'

# require models
Dir["./models/*.rb"].each {|file| require file }

# require routes
Dir["./routes/*.rb"].each {|file| require file }
require "./routes.rb"

enable :sessions
set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

def logger; settings.logger end

def no_authentication?
  false
end

configure do
  #  log to file in log folder
  log_file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  log_file.sync = true
  use Rack::CommonLogger, log_file
  logger = Logger.new(log_file)
  logger.level = Logger::DEBUG


  # set up authorization
  unless no_authentication?
    Google::Apis::ClientOptions.default.application_name = 'SheQL'
    Google::Apis::ClientOptions.default.application_version = '1.0.0'

    client_secrets = Google::APIClient::ClientSecrets.load
    authorization = client_secrets.to_authorization
    authorization.scope = 'openid email profile'

    set :authorization, authorization
  end

  set :no_auth_neededs, ['/login', '/authenticate', '/authenticated']

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
  unless logged_in? || settings.no_auth_neededs.include?(request.path_info) || no_authentication?
    redirect to('/login')
  end
end

after do
  unless no_authentication?
    set_user_session
  end
end