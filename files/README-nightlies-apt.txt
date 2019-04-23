Puppet, Inc. Nightly Apt Repositories

For official documentation and setup instructions, see:
https://puppet.com/docs/puppet/latest/puppet_platform.html

These repositories contain *UNSUPPORTED* packages intended for public
consumption. These packages contain software released by Puppet, Inc., e.g.
Puppet, Puppet Server, PuppetDB, etc.


## Installation
To add the repo for your distribution, install the release package with the
codename for your distribution. For example, on xenial:
wget http://nightlies.puppet.com/apt/puppet-nightly-release-xenial.deb;
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
