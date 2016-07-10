# Base image
FROM ruby:2.3.1

ENV HOME /home/rails/webapp

# Install PGsql dependencies,js engine and supervisor
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs supervisor ghostscript

WORKDIR $HOME

# Install gems
ADD Gemfile* $HOME/
RUN bundle install

# Add the app code
ADD . $HOME

#Copy docker database.yml
COPY database_assets_docker.yml /home/rails/webapp/config/database.yml

#Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

#Copy docker database.yml
COPY database_docker.yml /home/rails/webapp/config/database.yml

# Create supervisor log directory
RUN mkdir -p /var/log/supervisor

# Copy supervisor config file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

