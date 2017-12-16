#!/bin/bash


git clone https://github.com/Otus-DevOps-2017-11/epanoff_infra.git
cd epanoff_infra
git checkout Infra-2
./install_ruby.sh
./install_mongodb.sh
./deploy.sh
