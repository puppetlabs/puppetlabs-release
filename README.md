# puppetlabs-release/test-tools

### Overview
The puppetlabs-release repo is where all the automation lives to build release packages for the various repos maintained by Puppet Labs. This branch, the test-tools branch, is where the automation lives for building release packages for our internal test tool repos at http://test-tools.delivery.puppetlabs.net/. Not all of the platforms here have package management systems, so we only need to build release packages for those platforms that do.

### Runtime Requirements
The Gemfile specifies all of the needed ruby libraries to build a puppet-agent package. Additionally, the automation requires a VM to build within for each desired package.

#### Environment variables
##### VANAGON\_LOCATION
The location of Vanagon in the Gemfile can be overridden with the environment variable `VANAGON_LOCATION`. Can be set prior to `bundle install` or updated with `bundle update`.

* `0.3.14` - Specific tag from the Vanagon git repo
* `git@github.com:puppetlabs/vanagon#master` - Remote git location and tag
* `file:///workspace/vanagon` - Absolute file path
* `file://../vanagon` - File path relative to the project directory

### Building test-tools-release packages
* `bundle install ;bundle exec build test-tools-release ubuntu-14.04-amd64`

This will install the requirements specified in the Gemfile, pull a VM using the specifications in the platform definition (in this example, it would be using a vcloud template with the name "ubuntu-1404-x86_64", found in configs/platforms/ubuntu-14.04-amd64.rb). It then uses that vcloud image to download and install any buildtime dependencies, and then run through the build instructions for the test-tools-release package and dependencies.

### Adding new platforms
New platforms require a new platform entry in `configs/platforms`. Generally, this is all that needs to happen for a new platform, especially if it's a new version of a platform that already exists. However, if it's a new platform entirely, not just a new version, ther will likely be automation changes that are required. Make sure you know how the package management system on the new platform works, and check [the vanagon repo](https://github.com/puppetlabs/vanagon) to see if there are any vanagon changes required for this new plaform. If we've done things well, you should receive fairly explicit error messages about where the vanagon automation needs to be updated

## GPG Fun

### Exporting

To get the GPG keys exported for use inside a release package, enter the following comands.

    # To get a Debian compatible keychain file
    gpg --export 27D8D6F1 > debian_keychain.gpg

    # To get a RPM compatible ascii public key
    gpg --export --armor 27D8D6F1 > RPM_GPG_KEY


### Extending Lifetimes

Mainly used [this page](http://www.g-loaded.eu/2010/11/01/change-expiration-date-gpg-key/).


The quick steps are:

Identify the key you want to edit. For this example, I'll call it ABCDEF10.


    gpg --edit-key  ABCDEF10
    key 0
    expire
    5y
    y
    key 1
    expire
    5y
    y
    save
    gpg --keyserver pgp.mit.edu --send-keys ABCDEF10


