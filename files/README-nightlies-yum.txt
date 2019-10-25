Puppet, Inc. Nightly Yum Repositories

For official documentation and setup instructions, see:
https://puppet.com/docs/puppet/latest/puppet_platform.html

For help, please open a ticket in the CPR project at https://tickets.puppet.com
or reach out to us on Slack at https://slack.puppet.com/.

These repositories contain *UNSUPPORTED* packages intended for public
consumption. These packages contain unreleased software by Puppet, Inc., e.g.
Puppet, Puppet Server, PuppetDB, etc.


## Installation
To add the repo for your distribution, install the release package with the
version for your distribution. For example, on centos 7:
sudo rpm -Uvh https://nightlies.puppet.com/yum/puppet-nightly-release-el-7.noarch.rpm


## Recommendations for Mirroring

# Directly from S3 (preferred option):
aws s3 sync --exclude '*.html' s3://nightlies.puppet.com/yum /var/yum

# HTTPS via CloudFront (fastest outside of US):
wget -r https://nightlies.puppet.com/yum


## Retention Policy
Packages are removed from this repository after 30 days, unless there is only
one remaining package for a given project.
