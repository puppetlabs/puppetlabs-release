component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2017.06.22'

  if platform.is_deb?
    pkg.add_source 'file://files/puppet-nightly-keyring.gpg'
    pkg.install_file 'puppet-nightly-keyring.gpg', '/etc/apt/trusted.gpg.d/puppet-nightly-keyring.gpg'
  else
    pkg.add_source("file://files/RPM-GPG-KEY-nightly-puppetlabs")
    pkg.add_source("file://files/RPM-GPG-KEY-puppet.asc")
    pkg.install_file 'RPM-GPG-KEY-nightly-puppetlabs', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-nightly'
    pkg.install_file 'RPM-GPG-KEY-puppet.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release'
  end
end
