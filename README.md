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

    export GITHUB_ID="d8a90randomjunk1dasdsa"<br/>
    export GITHUB_SECRET="a89309adsrandomjunk1j9fajsJ"
    
1. Setup your environment variable for SEARCHIFY_HIBISCUS_API_URL from http://searchify.com/
   1. add the following to .bash_profile

    export SEARCHIFY_HIBISCUS_API_URL="http://something"<br/>
    export SEARCHIFY_HIBISCUS_INDEX="hibiscus"

   1. restart your terminal

1. Setup your environment variable for ARTICLE_USER_ID. This is used by the Article Generator.
   1. add the following to .bash_profile

    export ARTICLE_USER_ID="youruserid"<br/>

   1. restart your terminal

##Local mongo database
1. install mongo (See http://www.mongodb.org/display/DOCS/Quickstart+OS+X )


##Remote mongo database
1. setup your environment variable for MONGOHQ_URL from https://www.mongohq.com/home
The url looks like mongodb://<user>:<password>@staff.mongohq.com:<port>/<databasename>

#Installation directions for Heroku

1. heroku config:set GOOGLE_ANALYTICS:UA-12345678-1

