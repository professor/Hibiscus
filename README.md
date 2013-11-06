#Welcome to Hibiscus

![Hibiscus Logo](https://github.com/professor/Hibiscus/raw/master/public/images/hibiscus.jpg)
Permission granted to use this image from Mahesh "Vyoma" Bhat | KalaaLog.com

#Installation directions for development environment

1. Setup your environment variable for GITHUB_ID, GITHUB_SECRET
   1. Register your application with github at https://github.com/settings/applications
   1. Application name: Hibiscus development
   1. Main url: http://locallost
   1. Callback url: http://localhost:3000/auth/github/callback
   1. add the following to .bash_profile

<!-- code -->

    export GITHUB_ID="d8a90randomjunk1dasdsa"<br/>
    # should match "Client Id" from the Github applications page
    export GITHUB_SECRET="a89309adsrandomjunk1j9fajsJ"
    # should match "Client Secret" from the Github applications page

1. Setup your environment variable for SEARCHIFY_HIBISCUS_API_URL from http://searchify.com/
   1. add the following to .bash_profile

<!-- code -->

    export SEARCHIFY_HIBISCUS_API_URL="http://something"
    export SEARCHIFY_HIBISCUS_INDEX="hibiscus"

   1. restart your terminal

1. If you enable sending of emails in development environment, then setup your environment variable for emails. Currently this is only needed for testing article feed importer

<!-- code -->

    export SMTP_SERVER_USERNAME=
    SMTP_SERVER_PASSWORD=

1. Setup your environment variable for ARTICLE_USER_ID. This is used by the Article Generator.
   1. add the following to .bash_profile

<!-- code -->

    export ARTICLE_USER_ID="scotty"

   2. restart your terminal
   3. in terminal run "rake db:seed" to create default article user

## Troubleshooting

### OpenSSL error

> OpenSSL::SSL::SSLError: SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed

While trying to sign in through github, if you run into an error that resembles the above, follow below steps:

    # Get hold of a ssl certificate file
    sudo curl -O http://curl.haxx.se/ca/cacert.pem

    # Rename the certificate
    mv cacert.pem ~/cert.pem

    # add the SSL_CERT_FILE environment variable
    export SSL_CERT_FILE=~/cert.pem


##Local mongo database

1. install mongo (See http://www.mongodb.org/display/DOCS/Quickstart+OS+X )


##Remote mongo database
1. setup your environment variable for MONGOHQ_URL from https://www.mongohq.com/home
The url looks like mongodb://<user>:<password>@staff.mongohq.com:<port>/<databasename>

#Installation directions for Heroku

1. heroku config:set GOOGLE_ANALYTICS:UA-12345678-1

