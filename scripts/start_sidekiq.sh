#!/bin/bash

# while rake db:migrate:status | grep -q down
# do
#    sleep 10
# done


sleep 30
exec bundle exec sidekiq