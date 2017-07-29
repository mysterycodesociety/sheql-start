def set_user_session

end

get '/login' do
  # Page where user can log in
end

get '/authenticate' do
  # Request authorization
end

get '/authenticated' do
  # Exchange token with Google

  redirect to('/')
end

get '/logout' do
  # Clear the session and redirect to where user can log in

end