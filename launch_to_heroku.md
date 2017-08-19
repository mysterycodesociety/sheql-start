## Steps taken prior to this launch

1. Git add and git commit everything on master.  If you have branches that are ready, they should be merged into the master branch.
1. Push the master branch back to GitHub. The code that is committed and pushed to GitHub is the code that will be launched.
1. When you fetched from remote, a file called `config.ru` should have been added to the root.  This file tells Heroku what to run when your app launches.  Check that it's there.
1. If you use Google Auth, the `unless no_authentication?` block in `app.rb` was modified to alternatively load secrets from an environmental variable.  Change it to match the one below.
1. If you use Google Auth, add the '/graduation' route to the list of unauthorized routes in the `app.rb` file.

Change this:

```
# app.rb

configure do
 # there are a lot of lines in this configure block
 # ...

 # hey!  this line!
  set :no_auth_neededs, ['/login', '/authenticate', '/authenticated']

  set :logger, logger
end
````

To this:

```
# app.rb

configure do

 # there are a lot of lines in this configure block
 # don't change them

 # change this line
  set :no_auth_neededs, ['/login', '/authenticate', '/authenticated', '/graduation']


# don't change this one
  set :logger, logger
end

```


```
  # set up authorization
  unless no_authentication?
    Google::Apis::ClientOptions.default.application_name = 'SheQL'
    Google::Apis::ClientOptions.default.application_version = '1.0.0'

    ## This is the line that changes
    client_secrets = Google::APICLientSecrets.load rescue Google::APIClient::ClientSecrets.new(JSON.parse(ENV['CLIENT_SECRETS']))

    ## all other lines stay the same
    authorization = client_secrets.to_authorization
    authorization.scope = 'openid email profile'

    set :authorization, authorization
  end

```

## Launching your app to Heroku
1. Your teacher will clone your repo from GitHub.
1. Your teacher will run `heroku create name-of-app` and the app will be created.  Write down the entire domain of the new app.
1. If Google Auth is set up, go back to the Google [developer's console](https://console.developers.google.com) and add the new domain + '/authenticated' as an Authorized redirect URI.
 Download your client_secrets.json file after you updated your account (it changes after you add another redirect URI).
   - NOTE: you must hit Save after you add the new URI, and if it doesn't redirect you out of the redirect URI screen when you hit Save, it isn't really saved.
1. Push your repo to Heroku.
  `git push heroku master`

  Why does this work?  Because your teacher added `heroku` as a remote repository, just like GitHub is a remote repository.  So now that it is created, you can push.

1. Set environmental variable for client secrets.

In command line/terminal, type: `heroku config:set CLIENT_SECRETS='` and then paste the entire content of your `client_secrets.json` file and end your single quote.  You must use single quotes around our CLIENT_SECRETS, not double quotes.  Do you not add anything else.  An example might look like:

```
  $ heroku config:set CLIENT_SECRETS='{"web":{"client_id":"long-id.apps.googleusercontent.com","project_id":"sheql-175101","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://accounts.google.com/o/oauth2/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","client_secret":"some-secret-string","redirect_uris":["https://test-gmfholley.c9users.io/authenticated","http://localhost:4567/authenticated","https://sheql-test.herokuapp.com/authenticated"]}}'

```

1. Your app should be running. You can visit it to make sure.
1. Run your database migrations on Heroku by using the same command but with `heroku run` in front of it: `heroku run db:migrate`.  (Heroku should create your database automatically if you have it set up correctly.)
1. Run the seed files, if you have them: `heroku run db:seed`.

