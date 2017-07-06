project 'puppet-nightly-release' do |proj|
  proj.description 'Release packages for the Puppet repository'
  proj.release '1'
  proj.license 'ASL 2.0'
  proj.version '1.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppet.com'
  proj.target_repo 'puppet-nightly'
  proj.noarch

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
