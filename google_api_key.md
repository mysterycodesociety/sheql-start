In order to use Google Authentication on your website, your website needs to be validated with google.  Basically, Google wants to know who is using its service and that the owners of the service intended to use Google.   Google does this by creating unguessable credentials, so Google will know it is you when you use their service.

First, log in to your gmail account and then go to the [developer console](https://console.developers.google.com/projectselector/apis/credentials). On the left hand menu, click Credentials and your dashboard should have a button that says Create.  Click that.

<img src="./assets/google_developer_console.png" style="width:400px;" />

Next, Google prompts you to create your project.  Name it something that you will remember.

<img src="./assets/create_credentials.png" style="width:400px;" />

 Next Google knows which APIs you want credentials for.  Developers create APIs (Application Programming Interface) deliberately so that systems/computers can interact with their software.  They are the public methods/functions you can call that will 'do a thing'!  You, the developer, don't have to know how Google does it.  But you and Google both know that if you use their API, Google's software will respond in a particular way.

 We want credentials for something called `OAuth client ID`, which allows your users to log into your site using Google.  If you did _not_ use Google, your site would have to keep track of passwords and resetting passwords and making sure that your user's passwords could not be hacked.

<img src="./assets/create_api_credentials.png" style="width:400px;" />


You will be directed to the client id page.  Choose the `Web Application` option.  In the Authorized Redirect URIs section, you will want the name of the Cloud9 host you are currently using.  (This is the domain on cloud 9 when you run the Sinatra app + the route for where authenticated users should go when they first get logged in.  In this case, I am using the '/app' route as my starting place.
<img src="./assets/create_client_id.png" style="width:400px;" />

Once you set up the client ID, you will get a pop up wiht your client ID and your client secret.  Do not share your secret with anyone!  But save both of them temporarily somewhere safe for the time being.

<img src="./assets/client_secret.png" style="width:400px;" />


You will also want to provide some information to the user when you ask them to sign in on Google.  Go to the OAuthconsent screen tab.  If you have a logo, you can supply it.  But for right now, the bare minimum of what you need is a name for your project.  Fill that in and click Save.
<img src="./assets/google_set_up_form.png" style="width:400px;" />


Now we will need two other Google APIs enabled in order for this to work: the Contacts API and the Google+ API.  On the right-hand nav, switch from 'Credentials' to 'Library'.
<img src="./assets/google_library_dashboard.png" style="width:400px;" />

In the search bar, search for 'Contacts API'
<img src="./assets/google_library_dashboard.png" style="width:400px;" />

https://test-gmfholley.c9users.io/authenticate

<img src="./assets/download_secrets.png" style="width:400px;" />
