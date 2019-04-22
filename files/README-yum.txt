Puppet Labs Repositories

For official documentation and setup instructions see:
https://docs.puppet.com/puppet/latest/puppet_platform.html

These repositories contains packages intended for public consumption. These
packages are for software released by Puppet, Inc., e.g. Puppet, Puppet Server,
PuppetDB, etc.

Note that the 'dependencies', 'devel', and 'products' repositories have been
deprecated in favor of the 'puppet' and 'puppet5' repos.


# To add the repo for your distribution, install the release package with the
# version for your distribution. For example, on centos 7:
sudo rpm -Uvh http://yum.puppetlabs.com/puppet/puppet-release-el-7.noarch.rpm


## Recommendations for Mirroring

# Directly from S3 (preferred option):
aws s3 sync --exclude '*.html' s3://yum.puppetlabs.com /var/yum

# Rsync:
rsync -a rsync://rsync.puppet.com/packages/yum /var/yum

# HTTPS via CloudFront (fastest outside of US):
wget -r https://yum.puppetlabs.com


## Archives

Older (> 3 years old) releases are regularly removed from this repository.
Archives can be found in http://release-archives.puppet.com/yum

