project 'release-puppet7-nightly' do |proj|
  proj.no_packaging true unless platform.is_deb?

  proj.description 'apt.repos.puppet.com nightly release packages for Puppet 7'
  proj.release '1'
  proj.license 'ASL 2.0'
  proj.version '7.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.noarch

  proj.setting(:puppet_product, 'puppet7')
  proj.setting(:apt_component, 'nightly')
  proj.setting(:target_repo, "#{proj.puppet_product}-#{proj.apt_component}")

  proj.conflicts 'puppet-nightly-release'
  proj.conflicts 'puppet5-nightly-release'
  proj.conflicts 'puppet6-nightly-release'
  proj.conflicts 'puppet7-nightly-release'

  proj.conflicts 'release-puppet-nightly'
  proj.conflicts 'release-puppet6-nightly'

  proj.component 'gpg_key'
  proj.component 'repos_puppet_com'
end
