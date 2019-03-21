#!/usr/bin/env bash

chmod +x -R ./bin

if [[ $1 == "development" ]]; then
  bundle install
  rails db:migrate
  ./bin/rails server
elif [[ $1 == "production" ]]; then
  bundle install
  rails db:migrate
  ./bin/rails server -e production
elif [[ $1 == "production:test" ]]; then
  bundle install
  rails db:migrate

  rake crawler:movie[abcde]
  rake crawler:tv[aaaa]
  
  ./bin/rails server -e production
else
  $*
fi