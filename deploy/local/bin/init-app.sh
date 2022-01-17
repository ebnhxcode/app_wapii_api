#!/bin/sh
cd /app
/usr/local/bin/bundle install
/usr/local/bin/ruby bin/rails server -p 3030 -b 0.0.0.0