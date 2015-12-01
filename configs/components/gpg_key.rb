component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2015.03.31'

  if platform.is_deb?
    pkg.url 'file://files/pl-build-tools-keyring.gpg'
    pkg.md5sum '54750c69da33c7a715d94cba6950987b'
    pkg.install_file 'pl-build-tools-keyring.gpg', '/etc/apt/trusted.gpg.d/pl-build-tools-keyring.gpg'
  else
    pkg.url 'file://files/RPM-GPG-KEY-pl-build-tools.txt'
    pkg.md5sum 'a3d047e1c964346efd304524a0b17104'
    pkg.install_file 'RPM-GPG-KEY-pl-build-tools.txt', '/etc/pki/rpm-gpg/RPM-GPG-KEY-pl-build-tools'
  end
end
