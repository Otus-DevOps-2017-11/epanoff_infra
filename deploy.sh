#!/bin/bash

cd /home/appuser

git clone https://github.com/Otus-DevOps-2017-11/
git clone https://github.com/Otus-DevOps-2017-11/reddit.git
cd reddit && bundle install

puma -d

ps aux | grep puma
