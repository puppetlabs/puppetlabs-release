Puppet, Inc. Yum Repositories

For official documentation and setup instructions, see:
https://puppet.com/docs/puppet/latest/puppet_platform.html

These repositories contain packages intended for public consumption. These
packages are for software released by Puppet, Inc., e.g. Puppet, Puppet Server,
PuppetDB, etc.


## Installation
To add the repo for your distribution, install the release package with the
version for your distribution. For example, on centos 7:
sudo rpm -Uvh http://yum.puppetlabs.com/puppet-release-el-7.noarch.rpm


## Recommendations for Mirroring

# Directly from S3 (preferred option):
aws s3 sync --exclude '*.html' s3://yum.puppetlabs.com /var/yum

# Rsync:
rsync -a rsync://rsync.puppet.com/packages/yum /var/yum

# HTTPS via CloudFront (fastest outside of US):
wget -r https://yum.puppetlabs.com


## Nightlies
Nightly repositories and packages can be found at nightlies.puppet.com/yum

## Archives
Older (> 3 years old) releases are regularly removed from this repository.
Archives can be found at http://release-archives.puppet.com/yum

