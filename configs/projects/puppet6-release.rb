project 'puppet6-release' do |proj|
  proj.description 'Release packages for the Puppet 6 repository'
  proj.release '8'
  proj.license 'ASL 2.0'
  proj.version '6.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.target_repo 'puppet6'
  proj.noarch

  proj.setting(:target_repo, 'puppet6')

  proj.conflicts 'puppet-release'
  proj.conflicts 'puppet5-release'

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
