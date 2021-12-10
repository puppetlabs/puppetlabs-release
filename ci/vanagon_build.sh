#!/bin/bash

source /usr/local/rvm/scripts/rvm
rvm use 2.5.1
export VANAGON_SSH_KEY="$HOME/.ssh/id_rsa-acceptance"
export VANAGON_SSH_AGENT=true
eval "$(ssh-agent -t 24h -s)"
ssh-add "${HOME}/.ssh/id_rsa"
export TEAM=release
export BUNDLE_PATH=.bundle/gems
export BUNDLE_BIN=.bundle/bin

bundle install

COMPONENTS=($(ls -1 configs/components | sed -e 's/\..*$//'))
PROJECTS=($(ls -1 configs/projects | sed -e 's/\..*$//'))

PLATFORMS_RAW=($(ls -1 configs/platforms | sed -e 's/\..*$//'))
PLATFORMS=""

for i in "PLATFORMS_RAW[@]"
do
  PLATFORMS="${PLATFORMS},${i}"
done

echo $PLATFORMS

bundle exec vanagon build puppet-release debian-9-amd64