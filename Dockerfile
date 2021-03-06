# Base image
FROM phusion/passenger-ruby25

#TODO See if Passenger docker images can be used
#RUN sed -i '/jessie-updates/d' /etc/apt/sources.list

ENV HOME /home/rails/webapp
ENV RAILS_ENV production

# Add our APT repository
#RUN sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger jessie main > /etc/apt/sources.list.d/passenger.list'

# Install PGsql dependencies,js engine and passenger
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs ghostscript nginx-extras tzdata imagemagick

COPY docker/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml

RUN useradd kronos

WORKDIR $HOME

# Install gems
COPY Gemfile* $HOME/
RUN bundle install --without=development test && gem install foreman

# Add the app code
COPY . $HOME

# Make the app user owner of the app folder
RUN chown -R kronos $HOME

USER kronos

#Copy docker database.yml
COPY database_assets_docker.yml /home/rails/webapp/config/database.yml

#Precompile assets
RUN bundle exec rake assets:precompile

#Copy docker database.yml
COPY database_docker.yml /home/rails/webapp/config/database.yml

USER root

