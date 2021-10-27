project 'release-puppet7-stable' do |proj|
  proj.no_packaging true unless platform.is_deb?

  proj.description 'apt.repos.puppet.com stable release packages for Puppet 7'
  proj.release '1'
  proj.license 'ASL 2.0'
  proj.version '7.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.noarch

  proj.setting(:puppet_product, 'puppet7')
  proj.setting(:apt_component, 'stable')

  proj.conflicts 'puppet-release'
  proj.conflicts 'puppet5-release'
  proj.conflicts 'puppet6-release'
  proj.conflicts 'puppet7-release'

  proj.conflicts 'release-puppet-stable'
  proj.conflicts 'release-puppet6-stable'

  proj.component 'gpg_key'
  proj.component 'repos_puppet_com'
end
