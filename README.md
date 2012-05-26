#Welcome to Hibiscus
     

![Hibiscus Logo](https://github.com/professor/Hibiscus/raw/master/public/images/hibiscus.jpg)
Permission granted to use this image from Mahesh "Vyoma" Bhat | KalaaLog.com 


Installation Steps

1. Fork the project from github.
2. Get Mongo. Follow instructions mentioned at http://www.mongodb.org/display/DOCS/Quickstart to download mongodb.
3. You need to set 2 environment variables GITHUB_ID and GITHUB_SECRET. Omniauth needs these 2 variables.
4. You can get new GITHUB_ID and GITHUB secret, by following the below steps
    - goto developer.github.com
    - goto Summary - Oauth
    - click on Register their application
    - enter name
    - enter URL as http://localhost:3000
    - enter Callback URL as http://localhost:3000/auth/github/callback
    - click on Register application
    - ClientId = Github id ,  Secret = Github_Secret
    - Use below link to update these 2 environment variables
    http://stackoverflow.com/questions/135688/setting-environment-variables-in-os-x

