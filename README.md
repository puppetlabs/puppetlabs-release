# puppetlabs-release

Uses fpm to build puppetlabs-release packages for all the platforms that we support.

See the [doc](./doc) directory for external documentation.

## Continuous Integration

Build and ship jobs are defined in `Jenkinsfile.build` and `Jenkinsfile.ship`. They are

Pull requests / build jobs run here:

https://jenkins-sre.delivery.puppetlabs.net/job/pipeline_puppetlabs-release_build

Ship job:

https://jenkins-sre.delivery.puppetlabs.net/job/pipeline_puppetlabs-release_ship-release-packages/

## Typical Process

- Create feature branch
- Make changes.
- Build and test locally by installing debs/rpm on a vmpooler machine
- After testing, be sure to increment the "release" number for the affected projects
- Create the PR, check CI for errors
- After the PR is merged, check again for errors
- Run the ship job to publish the updated packages

## Development

### Local builds

  - bundle install
  - bundle exec rake build

### template files

Template files are located in the `source/<target-website>` directory. There are target-websites
defined for `yum.puppet.com`, `apt.puppet.com`, and `nightlies.puppet.com`

### project JSON files

Somewhat like vanagon project .rb files, the JSON files in `source/projects` are merged with
the template files to create the combinations needed to package.

Each project is versioned manually in the project JSON file. Before shipping a new version, increment the "release" number.

## Planned Improvements

Some aspects of the ship process are awkward because we rely on the peculiarities of the `packaging` gem for shipping. We plan on making changes to the `packaging` gem to make things less peculiar.
