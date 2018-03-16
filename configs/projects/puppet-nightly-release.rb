project 'puppet-nightly-release' do |proj|
  proj.description 'Release packages for the Puppet repository'
  proj.release '3'
  proj.license 'ASL 2.0'
  proj.version '1.0.0'
  proj.vendor 'Puppet Labs <info@puppetlabs.com>'
  proj.homepage 'https://www.puppet.com'
  proj.target_repo 'puppet-nightly'
  proj.noarch

  proj.conflicts 'puppet5-nightly-release'

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
