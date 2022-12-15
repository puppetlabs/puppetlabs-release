Puppet, Inc. Nightly Yum Repositories

For documentation and setup instructions, see:
https://www.puppet.com/docs/puppet/latest/install_puppet.html#install_puppet

For help, open a ticket in the CPR project at https://tickets.puppet.com
or contact us on Slack at https://slack.puppet.com

These repositories contain UNSUPPORTED packages intended for public
consumption. These packages contain unreleased software by Puppet, Inc.:
Puppet, Puppet Server, PuppetDB, etc.


## Installation
To add the repo to a distribution, install the release package with the
version for the distribution. For example, on centos 7:
sudo rpm -Uvh https://nightlies.puppet.com/yum/puppet-nightly-release-el-7.noarch.rpm


## Recommendations for Mirroring

# Directly from S3 (preferred option):
aws s3 sync --exclude '*.html' s3://nightlies.puppet.com/yum /var/yum

# HTTPS via CloudFront (fastest outside of US):
wget -r https://nightlies.puppet.com/yum


## Retention Policy
Packages are removed from this repository after 30 days, unless there is only
one remaining package for a given project.
