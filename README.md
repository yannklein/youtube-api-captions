# Yann's notes

I based my code on those links:
- [the api ruby client raw code itself](https://github.com/googleapis/google-api-ruby-client/blob/master/google-api-client/generated/google/apis/youtube_v3/service.rb)
- [the api doc](https://developers.google.com/youtube/v3/docs/captions/download)
- [the ruby quickstart code for the authorize part](https://developers.google.com/youtube/v3/quickstart/ruby)

I got a Desktop client Oauth2 credential from [the Google Dev Console](https://console.cloud.google.com/apis/credentials?project=test-api-1553671520706)

# How to use

It’s a sinatra app, clone it and try it this way:
- in your terminal:  `ruby app.rb`
- then on Chrome access: `http://localhost:4567/youtube/RkNr9zBUaE4`
- The first time, there should be a message in your terminal to do some process to get the access token. After you get and paste the token in the terminal you should see that:
![image](https://user-images.githubusercontent.com/26819547/185024295-f980e79e-21f5-43b6-a040-c4be1b7322ff.png)


# API Samples

This directory contains a simple Sinatra web app illustrating how to use the client
in a server-side web environment.

It illustrates a few key concepts:

* Using [Google Sign-in](https://developers.google.com/identity) for authentication.
* Using the [googleauth gem](https://github.com/google/google-auth-library-ruby) to
  request incremental authorization as more permissions are needed.

# Setup

* Create a project at https://console.developers.google.com
* Go to the `API Manager` and enable the `Drive` and `Calendar` APIs
* Go to `Credentials` and create a new OAuth Client ID of type 'Web application'
    * Use `http://localhost:4567/oauth2callback` as the redirect URL
    * Use `http://localhost:4567` as the JavaScript origin

Additional details on how to enable APIs and create credentials can be
found in the help guide in the console.

## Example Environment Settings

For convenience, application credentials can be read from the shell environment
or placed in a .env file.

After setup, your .env file might look something like:

```
GOOGLE_CLIENT_ID=479164972499-i7j6av7bp2s4on5ltb7pjXXXXXXXXXX.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=JBotCTG5biFWGzXXXXXXXXXX
```

# Running the samples

To start the server, run

```
ruby app.rb
```

Open `http://localhost:4567/` in your browser to explore the sample.

