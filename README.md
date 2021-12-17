puppetlabs-release
==================

Repo for yum and apt release packages with Puppet's signing key.

See "Build and Ship a Release Package" in Confluence
(https://confluence.puppetlabs.com/pages/viewpage.action?pageId=159652513)
for details.

NOTE: We must now set the project using the `PROJECT_OVERRIDE` environment
variable when performing tasks with the packaging repo.

Pushes to this repository kickoff the https://jenkins-sre.delivery.puppetlabs.net/view/release-engineering/job/pipeline_puppetlabs-release_vanagon-build/ job that uses vanagon to build all of the projects.