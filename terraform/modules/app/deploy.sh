#!/bin/bash

cd /home/appuser

git clone https://github.com/Otus-DevOps-2017-11/reddit.git
cd reddit && bundle install

sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
