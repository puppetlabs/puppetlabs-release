component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2015.03.31'

  if platform.is_deb?
    pkg.url 'file://files/pl-build-tools-keyring.gpg'
    pkg.md5sum 'a58d53285fa03c59d3b684f1a10855af'
    pkg.install_file 'pl-build-tools-keyring.gpg', '/etc/apt/trusted.gpg.d/pl-build-tools-keyring.gpg'
  else
    pkg.url 'file://files/RPM-GPG-KEY-pl-build-tools.asc'
    pkg.md5sum '7b4ed31e1028f921b5c965df0a42e508'
    pkg.install_file 'RPM-GPG-KEY-pl-build-tools.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-pl-build-tools'
  end
end
