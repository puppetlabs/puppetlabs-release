# puppetlabs-release/pl-build-tools

### Overview
The puppetlabs-release repo is where all the automation lives to build release packages for the various repos maintained by Puppet Labs. This branch, the pl-build-tools branch, is where the automation lives for building release packages for our internal build tool repos at http://pl-build-tools.delivery.puppetlabs.net/. Not all of the platforms here have package management systems, so we only need to build release packages for those platforms that do.

### Runtime Requirements
The Gemfile specifies all of the needed ruby libraries to build a puppet-agent package. Additionally, the automation requires a VM to build within for each desired package.

### Building pl-build-tools-release packages
* `bundle install ;bundle exec build pl-build-tools-release ubuntu-14.04-amd64`

This will install the requirements specified in the Gemfile, pull a VM using the specifications in the platform definition (in this example, it would be using a vcloud template with the name "ubuntu-1404-x86_64", found in configs/platforms/ubuntu-14.04-amd64.rb). It then uses that vcloud image to download and install any buildtime dependencies, and then run through the build instructions for the pl-build-tools-release package and dependencies.

### Adding new platforms
New platforms require a new platform entry in `configs/platforms`. Generally, this is all that needs to happen for a new platform, especially if it's a new version of a platform that already exists. However, if it's a new platform entirely, not just a new version, ther will likely be automation changes that are required. Make sure you know how the package management system on the new platform works, and check [the vanagon repo](https://github.com/puppetlabs/vanagon) to see if there are any vanagon changes required for this new plaform. If we've done things well, you should receive fairly explicit error messages about where the vanagon automation needs to be updated
