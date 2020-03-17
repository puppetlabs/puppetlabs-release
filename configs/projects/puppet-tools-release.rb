project 'puppet-tools-release' do |proj|
  proj.description 'Release packages for the puppet-tools repository'
  proj.release '4'
  proj.license 'ASL 2.0'
  proj.version '1.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppet.com'
  proj.target_repo 'puppet-tools'
  proj.noarch

  proj.setting(:target_repo, 'puppet-tools')

  proj.conflicts 'puppet-enterprise-tools-release'
  proj.replaces 'puppet-enterprise-tools-release'

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
