component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2017.06.22'

  if platform.is_deb?
    pkg.add_source 'file://files/puppet5-keyring.gpg'
    pkg.install_file 'puppet5-keyring.gpg', '/etc/apt/trusted.gpg.d/puppet5-keyring.gpg'
  else
    pkg.add_source 'file://files/RPM-GPG-KEY-puppet5.asc'
    pkg.install_file 'RPM-GPG-KEY-puppet5.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet5'
  end
end
