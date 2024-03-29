Puppet, Inc. Nightly Apt Repositories

For documentation and setup instructions, see:
https://www.puppet.com/docs/puppet/latest/install_puppet.html#install_puppet

For help, open a ticket in the CPR project at https://tickets.puppet.com
or contact us on Slack at https://slack.puppet.com

These repositories contain UNSUPPORTED packages intended for public
consumption. These packages contain software released by Puppet, Inc.:
Puppet, Puppet Server, PuppetDB, etc.


## Installation
To add the repo for a distribution, install the release package with the
codename for your distribution. For example, on xenial:

wget http://nightlies.puppet.com/apt/puppet-nightly-release-xenial.deb
sudo dpkg -i puppet-nightly-release-xenial.deb
sudo apt-get update


## Recommendations for Mirroring

# Directly from S3 (preferred option):
aws s3 sync --exclude '*.html' s3://nightlies.puppet.com/apt /var/apt

# HTTPS via CloudFront (fastest outside of US):
wget -r https://nightlies.puppet.com/apt


## Retention Policy
Packages are removed from this repository after 30 days, unless there is only
one remaining package for a given project.
