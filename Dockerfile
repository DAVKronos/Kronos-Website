# Base image
FROM ruby:2.3.1

ENV HOME /home/rails/webapp

# Install PGsql dependencies,js engine and supervisor
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs supervisor

WORKDIR $HOME

# Install gems
ADD Gemfile* $HOME/
RUN bundle install

# Add the app code
ADD . $HOME

# Create supervisor log directory
RUN mkdir -p /var/log/supervisor

# Copy supervisor config file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

