Puppet, Inc. Yum Repositories

For documentation and setup instructions, see:
https://www.puppet.com/docs/puppet/latest/install_puppet.html#install_puppet

For help, open a ticket in the CPR project at https://tickets.puppet.com
or contact us on Slack at https://slack.puppet.com

These repositories contain packages intended for public consumption. These
packages are for software released by Puppet, Inc.: Puppet, Puppet Server,
PuppetDB, etc.


## Installation
To add the repo to a distribution, install the release package with the
version for the distribution. For example, on centos 7:

sudo rpm -Uvh https://yum.puppet.com/puppet-release-el-7.noarch.rpm


## Recommendations for Mirroring

# Directly from S3 (preferred option):
aws s3 sync --exclude '*.html' s3://yum.puppetlabs.com /var/yum

# Rsync:
rsync -a rsync://rsync.puppet.com/packages/yum /var/yum

# HTTPS via CloudFront (fastest outside of US):
wget -r https://yum.puppet.com


## Nightlies
Nightly repositories and packages can be found at nightlies.puppet.com/yum

## Archives
Older (> 3 years old) releases are regularly removed from this repository.
Archives can be found at https://release-archives.puppet.com/yum
