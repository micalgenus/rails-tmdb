#!/usr/bin/env bash

chmod +x -R ./bin

if [[ $1 == "development" ]]; then
  bundle install
  rails db:migrate
  ./bin/rails server
elif [[ $1 == "production" ]]; then
  bundle install
  rails db:migrate
  rails assets:precompile
  ./bin/rails server -e production
else
  $*
fi