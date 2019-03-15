#!/usr/bin/env bash

bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java
bundle install

./bin/rails server