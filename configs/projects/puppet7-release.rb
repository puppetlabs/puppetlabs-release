project 'puppet7-release' do |proj|
  proj.description 'Release packages for the Puppet 7 repository'
  proj.release '10'
  proj.license 'ASL 2.0'
  proj.version '7.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.target_repo 'puppet7'
  proj.noarch

  proj.setting(:target_repo, 'puppet7')

  proj.conflicts 'puppet-release'

  proj.conflicts 'puppet5-release'
  proj.replaces 'puppet5-release'

  proj.conflicts 'puppet6-release'
  proj.replaces 'puppet6-release'

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
