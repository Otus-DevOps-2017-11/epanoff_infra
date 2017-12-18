#!/bin/bash


git clone -b Infra-2 https://github.com/Otus-DevOps-2017-11/epanoff_infra.git
cd epanoff_infra
./install_ruby.sh
./install_mongodb.sh
./deploy.sh
