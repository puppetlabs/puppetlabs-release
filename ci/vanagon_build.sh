#!/bin/bash

source /usr/local/rvm/scripts/rvm
rvm use 2.5.1
export VANAGON_SSH_KEY="$HOME/.ssh/id_rsa-acceptance"
export VANAGON_SSH_AGENT=true
eval "$(ssh-agent -t 24h -s)"
ssh-add "${HOME}/.ssh/id_rsa"
export TEAM=release

gem install vanagon
vanagon build puppet-release debian-9-amd64