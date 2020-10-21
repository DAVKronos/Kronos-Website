#!/bin/bash

bundle check || bundle install
bundle exec ./bin/webpack-dev-server &
bundle exec passenger start