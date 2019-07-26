#!/bin/bash

# 使い方:
# bash bin/set_heroku_variables.sh
heroku config:set RAILS_MASTER_KEY="$(< config/master.key)"
heroku config:set GOOGLE_APPLICATION_CREDENTIALS="$(< config/secrets/it-benkyoukai-meishi.json)"
heroku config:set MAGICK_CONFIGURE_PATH="/app/.magick/:/etc/ImageMagick-6/"
