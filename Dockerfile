# Base image
FROM ruby:3.1.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    wget -qO- https://deb.nodesource.com/setup_16.x | bash && \
    apt-get update && apt-get install -qq -y nodejs=16.* yarn=1.* \
    imagemagick

COPY docker/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml

WORKDIR /app
COPY package.json yarn.lock /app
RUN yarn install --frozen-lockfile && yarn cache clean

COPY Gemfile Gemfile.lock /app
RUN bundle install

CMD ["bin/rails", "server", "-u", "puma", "-b", "0.0.0.0"]
