#!/bin/bash

bundle check || bundle install
bundle exec passenger start &
bundle exec ./bin/webpack-dev-server