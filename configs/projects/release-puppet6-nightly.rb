project 'release-puppet6-nightly' do |proj|
  proj.no_packaging true unless platform.is_deb?

  proj.description 'apt.repos.puppet.com nightly release packages for Puppet 6'
  proj.release '1'
  proj.license 'ASL 2.0'
  proj.version '6.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.noarch

  proj.setting(:puppet_product, 'puppet6')
  proj.setting(:apt_component, 'nightly')

  proj.conflicts 'puppet-release'
  proj.conflicts 'puppet5-release'
  proj.conflicts 'puppet6-release'
  proj.conflicts 'puppet7-release'

  proj.conflicts 'release-puppet-nightly'
  proj.conflicts 'release-puppet7-nightly'

  proj.component 'gpg_key'
  proj.component 'repos_puppet_com'
end
