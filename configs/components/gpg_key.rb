component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2018.3.22'

  if platform.is_deb?
    pkg.add_source 'file://files/puppet6-nightly-keyring.gpg'
    pkg.install_file 'puppet6-nightly-keyring.gpg', '/etc/apt/trusted.gpg.d/puppet6-nightly-keyring.gpg'
  else
    pkg.add_source("file://files/RPM-GPG-KEY-puppet.asc")
    pkg.install_file 'RPM-GPG-KEY-puppet.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet6-nightly-release'

  end
end
