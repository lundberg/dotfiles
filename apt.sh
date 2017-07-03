#!/usr/bin/env bash

# Install pip

function run {
  sudo -u root su -l -c "${@}"
}

run "apt-get --yes install python-dev python-setuptools python3-pip silversearcher-ag"
run "easy_install pip"
run "pip install setuptools --upgrade"

unset run

