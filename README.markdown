# Kronos-Website
This is the repository of the Kronos Website.

### Requirements
For developing on the Kronos Website you need the following software installed.

* Docker
* Docker Compose (version > 1.6)

If you install docker toolbox or docker for Mac/Windows this is also fine because this contains these components.


### Installation
To use all the functionality you need to create a .env file in the root directory of the project. This needs to contain at least
an entry for the localeapp api key. It looks like this:
    
    LOCALEAPP_API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    RAILS_ENV=development
    GMAIL_SMTP_PASSWORD=xxxxxxxxxxxxx

### Running
Currently the website always runs in production, this has the effect that you need to redo these steps after every change.

    $ docker-compose build
    $ docker-compose up

Now you have created the docker images and they start running. If this is the first time you run this or you are using a new database image you will notice that the site does not start. The site does not start because the database is not created yet. Keep the instances running and execute the following commands to create the database:

    $ docker exec kronoswebsite_app_1 bundle exec rake db:create
    $ docker exec kronoswebsite_app_1 bundle exec rake db:schema:load
    $ docker exec kronoswebsite_app_1 bundle exec rake db:seed

Now restart the instances running with docker compose:

    Ctrl-c
    $ docker-compose up

At this time the website should run properly on port 3000 (depends on your docker installation if this is at localhost or a different ip).
