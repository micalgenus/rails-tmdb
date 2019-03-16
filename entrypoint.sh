#!/usr/bin/env bash

if [[ $1 == "development" ]]; then
  bundle install

  ./bin/rails server
else
  $*
fi