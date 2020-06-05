#!/bin/bash

# if [ -e /app ]; then
#   SEEDED_FILE=/app/.already_seeded 
#   rm /app/tmp/pids/server.pid
#   pushd /app

#   if [ -e $SEEDED_FILE ]; then
#     runuser -u app rake db:migrate || { echo "Can't migrate database"; exit 1; }
#   else
#     runuser -u app rake db:create
#     runuser -u app rake db:migrate || { echo "Can't migrate database"; exit 1; }
#     runuser -u app rake db:seed    || { echo "Can't seed database"; exit 1; }
#     echo 1 > $SEEDED_FILE
#   fi

#   runuser -u app rake tmp:clear || { echo "Can't clear cache"; }
#   popd
# fi

rake db:create
rake db:migrate || { echo "Can't migrate database"; exit 1; }
rake db:seed    || { echo "Can't seed database"; exit 1; }
rake tmp:clear  || { echo "Can't clear cache"; }
rails s -b 0.0.0.0