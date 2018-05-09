worker: bundle exec rake jobs:work
web: bundle exec rails s 
# COMMENT ABOVE LINE OUT FOR PRODUCTION ONLY. THIS WILL BREAK HEROKU IF PUSHED

# web: bundle exec puma -p $PORT -C ./config/puma.rb # COMMENT THIS LINE OUT FOR LOCAL ONLY.

# If the above is bombing out, use: rm /usr/local/var/postgres/postmaster.pid
# It may also be necessary to reinstall postgres, and restart the server:
# brew reinstall postgresql
# brew services start postgresql