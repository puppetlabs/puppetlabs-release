component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2015.03.31'

  if platform.is_deb?
    pkg.url 'file://files/pl-build-tools-keyring.gpg'
    pkg.md5sum '0a22f4fdcfd0d61a11b533443b315d25'
    pkg.install_file 'pl-build-tools-keyring.gpg', '/etc/apt/trusted.gpg.d/pl-build-tools-keyring.gpg'
  else
    pkg.url 'file://files/RPM-GPG-KEY-pl-build-tools.gpg'
    pkg.md5sum '339014f9b0517552c232501438f40b3d'
    pkg.install_file 'RPM-GPG-KEY-pl-build-tools.gpg', '/etc/pki/rpm-gpg/RPM-GPG-KEY-pl-build-tools'
  end
end
