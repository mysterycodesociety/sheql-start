def set_user_session
  session[:access_token] = user_credentials.access_token
  session[:refresh_token] = user_credentials.refresh_token
  session[:expires_in] = user_credentials.expires_in
  session[:issued_at] = user_credentials.issued_at
end

get '/login' do
  # Page where user can log in
  "Hi!  This is my app.  <a href='/authenticate' > Log in Using Google </a>"
end

get '/authenticate' do
  # Request authorization
  redirect user_credentials.authorization_uri.to_s, 303
end

get '/authenticated' do
  # Exchange token with Google
  user_credentials.code = params[:code] if params[:code]
  user_credentials.fetch_access_token!

  # set user tokens into session
  set_user_session

  # use user tokens to request their profile information
  info_service = Google::Apis::Oauth2V2::Oauth2Service.new
  info = info_service.get_userinfo(options: { authorization: user_credentials.access_token })

  # save profile information to session
  session[:email] = info.email
  session[:family_name] = info.family_name
  session[:given_name] = info.given_name
  session[:gender] = info.gender
  session[:name] = info.name
  session[:picture] = info.picture


  # Once your User model is set up, uncomment this
  # You could also choose to create/save some of the information to the database instead
  #
  # User.find_or_create_by(email: session[:email]) do |user|
  #   user.name = session[:name]
  #   user.picture = session[:picture]
  # end

  redirect to('/')
end

get '/logout' do
  # Clear the session and redirect to where user can log in
  session.clear
  redirect to('/login')
end