# Base image
FROM phusion/passenger-ruby26

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Run in production mode
ENV RAILS_ENV production

# Install dependencies like nodejs and yarn
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -qq -y python build-essential nodejs yarn libcurl4-openssl-dev \
    libpq-dev \
    ghostscript nginx-extras tzdata imagemagick

# Apply the fix for ImageMagick to accept PDF
COPY docker/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml

WORKDIR /home/app

# Copy the Gemfile and lockfile with the right owner
COPY --chown=app:app package.json yarn.lock Gemfile*  /home/app/

# Install the gems with all available processors
RUN yarn install --frozen-lockfile --production && \
    bundle config --global frozen 1 && \
    bundle config --global without development test && \
    bundle config --global build.nokogiri --use-system-libraries && \
    bundle install -j $(nproc) && \
    gem install foreman

# Add all files to the image and make the app user owner of the app folder
ADD --chown=app:app . /home/app/

#Precompile assets
RUN bundle exec rake assets:precompile
RUN bundle exec rails webpacker:compile
