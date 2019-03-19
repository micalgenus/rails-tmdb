#!/usr/bin/env bash

if [[ $1 == "development" ]]; then
  bundle install

  rails db:migrate

  ./bin/rails server
else
  $*
fi