component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2016.11.01'

  if platform.is_deb?
    pkg.add_source("file://files/internal-tools-keyring.gpg")
    pkg.install_file 'internal-tools-keyring.gpg', '/etc/apt/trusted.gpg.d/internal-tools-keyring.gpg'
  else
    pkg.add_source("file://files/RPM-GPG-KEY-internal-tools.asc")
    pkg.add_source("file://files/RPM-GPG-KEY-puppet.asc")
    pkg.install_file 'RPM-GPG-KEY-internal-tools.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-internal-tools'
    pkg.install_file 'RPM-GPG-KEY-puppet.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-internal-tools'
  end
end
