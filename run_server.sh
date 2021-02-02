#!/bin/bash

rm -f tmp/pids/server.pid
bundle install --jobs 4 --retry 3 --clean
yarn install
bundle exec rake ridgepole:apply
bundle exec rails s -p 3000 -b 0.0.0.0
