Puppet, Inc. Apt Repositories

For official documentation and setup instructions, see:
https://puppet.com/docs/puppet/latest/puppet_platform.html

These repositories contain packages intended for public consumption. These
packages contain software released by Puppet, Inc., e.g. Puppet, Puppet Server,
PuppetDB, etc.


## Installation
To add the repo for your distribution, install the release package with the
codename for your distribution. For example, on xenial:
wget http://apt.puppetlabs.com/puppet-release-xenial.deb;
sudo dpkg -i puppet-release-xenial.deb
sudo apt-get update


## Recommendations for Mirroring

# Directly from S3 (preferred option):
aws s3 sync --exclude '*.html' s3://apt.puppetlabs.com /var/apt

# Rsync:
rsync -a rsync://rsync.puppet.com/packages/apt /var/apt

# HTTPS via CloudFront (fastest outside of US):
wget -r https://apt.puppetlabs.com


## Nightlies
Nightly repositories and packages can be found at nightlies.puppet.com/apt

## Archives
Older (> 3 years old) releases are regularly removed from this repository.
Archives can be found at http://release-archives.puppet.com/apt

