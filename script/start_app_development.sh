#!/bin/bash

bundle check || bundle install
bundle exec passenger start