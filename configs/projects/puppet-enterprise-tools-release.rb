project 'puppet-enterprise-tools-release' do |proj|
  proj.description 'Release packages for the puppet-enterprise-tools repository'
  proj.release '1'
  proj.license 'ASL 2.0'
  proj.version '1.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppet.com'
  proj.target_repo 'puppet-enterprise-tools'
  proj.noarch

  proj.setting(:target_repo, 'puppet-enterprise-tools')

  proj.conflicts 'puppet-release'
  proj.conflicts 'puppet5-release'
  proj.conflicts 'puppet6-release'

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
