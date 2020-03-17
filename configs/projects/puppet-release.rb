project 'puppet-release' do |proj|
  proj.description 'Release packages for the Puppet repository'
  proj.release '10'
  proj.license 'ASL 2.0'
  proj.version '1.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.target_repo 'puppet'
  proj.noarch

  proj.setting(:target_repo, 'puppet')

  proj.conflicts 'puppet5-release'
  proj.conflicts 'puppet6-release'

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
