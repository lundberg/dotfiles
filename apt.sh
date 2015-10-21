#!/usr/bin/env bash

# Install pip

function run {
  sudo -u root su -l -c "${@}"
}

run "apt-get --yes install python-dev python-setuptools"
run "easy_install pip"
run "pip install setuptools --upgrade"

unset run

