component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2016.11.03'

  if platform.is_deb?
    pkg.add_source("file://files/test-tools-keyring.gpg")
    pkg.install_file 'test-tools-keyring.gpg', '/etc/apt/trusted.gpg.d/test-tools-keyring.gpg'
  else
    pkg.add_source("file://files/RPM-GPG-KEY-test-tools.asc")
    pkg.add_source("file://files/RPM-GPG-KEY-puppet.asc")
    pkg.install_file 'RPM-GPG-KEY-test-tools.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-test-tools'
    pkg.install_file 'RPM-GPG-KEY-puppet.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-test-tools'
  end
end
