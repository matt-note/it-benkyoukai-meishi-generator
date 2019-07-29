#!/bin/bash

# 説明
# config/application.yml を参照して、
# Herokuで環境変数を設定するスクリプトです。

# 使い方
# bash bin/figaro.sh
figaro heroku:set -e production
