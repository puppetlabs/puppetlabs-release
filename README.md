# puppetlabs-release

Uses fpm to build puppetlabs-release packages for all the platforms that we support.

See the [doc](./doc) directory for external documentation.

## Continuous Integration

Repo for yum and apt release packages with Puppet's signing key.

Merging to the main branch runs the Jenkins job:

https://jenkins-sre.delivery.puppetlabs.net/job/pipeline_puppetlabs-release_vanagon-build

## Local builds

  - bundle install
  - bundle exec rake build

`*.template` files for yum `.repo` and apt `.list` are merged with JSON configuration files from the `source` directory.

This results in an intermediate `build` directory of small trees for fpm to create appropriate `.rpm` and `.deb` files from.

The fpm output files are left in the `output` directory per conventions set by the `packaging` gem.
