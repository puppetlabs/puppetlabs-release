project 'release-puppet-stable' do |proj|
  proj.no_packaging true unless platform.is_deb?

  proj.description 'apt.repos.puppet.com stable release packages for the latest Puppet'
  proj.release '1'
  proj.license 'ASL 2.0'
  proj.version '7.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.noarch

  proj.setting(:puppet_product, 'puppet7')
  proj.setting(:apt_component, 'stable')
  proj.setting(:target_repo, "#{proj.puppet_product}-#{proj.apt_component}")

  proj.conflicts 'puppet-release'
  proj.conflicts 'puppet5-release'
  proj.conflicts 'puppet6-release'
  proj.conflicts 'puppet7-release'

  proj.conflicts 'release-puppet6-stable'
  proj.conflicts 'release-puppet7-stable'

  proj.component 'gpg_key'
  proj.component 'repos_puppet_com'
end
