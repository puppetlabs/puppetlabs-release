component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2015.03.31'

  if platform.is_deb?
    pkg.url 'file://files/pl-build-tools-keyring.gpg'
    pkg.md5sum 'b19d2300c48863f4c61ff7aecd98e3c3'
    pkg.install_file 'pl-build-tools-keyring.gpg', '/etc/apt/trusted.gpg.d/pl-build-tools-keyring.gpg'
  else
    pkg.url 'file://files/RPM-GPG-KEY-pl-build-tools.gpg'
    pkg.md5sum '3efba73605e1a9a890a7a371f8f8fc56'
    pkg.install_file 'RPM-GPG-KEY-pl-build-tools.gpg', '/etc/pki/rpm-gpg/RPM-GPG-KEY-pl-build-tools'
  end
end
