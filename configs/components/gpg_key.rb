component 'gpg_key' do |pkg, _, platform|
  pkg.version '2021.07.08'

  if platform.is_deb?
    pkg.add_source('file://files/pl-build-tools-keyring.gpg')
    pkg.install_file 'pl-build-tools-keyring.gpg',
                     '/etc/apt/trusted.gpg.d/pl-build-tools-keyring.gpg'
  else
    pkg.add_source('file://files/RPM-GPG-KEY-pl-build-tools.asc')
    pkg.add_source('file://files/RPM-GPG-KEY-puppet.asc')
    pkg.add_source('file://files/RPM-GPG-KEY-puppet-2025-04-06.pub')
    pkg.install_file 'RPM-GPG-KEY-puppet-2025-04-06.pub',
                     '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-2025-04-06.pub'
  end
end
