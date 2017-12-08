component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2016.10.05'

  if platform.is_deb?
    pkg.add_source 'file://files/puppet-nightly-keyring.gpg'
    pkg.install_file 'puppet-nightly-keyring.gpg', '/etc/apt/trusted.gpg.d/puppet-nightly-keyring.gpg'
  else
    pkg.add_source("file://files/RPM-GPG-KEY-puppet.asc")
    pkg.install_file 'RPM-GPG-KEY-puppet.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-nightly-release'

  end
end
