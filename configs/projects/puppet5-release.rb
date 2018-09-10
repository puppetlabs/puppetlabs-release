project 'puppet5-release' do |proj|
  proj.description 'Release packages for the Puppet5 repository'
  proj.release '2'
  proj.license 'ASL 2.0'
  proj.version '5.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppet.com'
  proj.target_repo 'puppet5'
  proj.noarch

  proj.conflicts 'puppet-release'
  proj.conflicts 'puppet-nightly-release'

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
