component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2015.03.31'

  if platform.is_deb?
    pkg.url 'file://files/puppetlabs-keyring.gpg'
    pkg.md5sum 'a58d53285fa03c59d3b684f1a10855af'
    pkg.install_file 'puppetlabs-keyring.gpg', '/etc/apt/trusted.gpg.d/puppetlabs-pc1-keyring.gpg'
  else
    pkg.url 'file://files/RPM-GPG-KEY-puppetlabs.gpg'
    pkg.md5sum '339014f9b0517552c232501438f40b3d'
    pkg.install_file 'RPM-GPG-KEY-puppetlabs.gpg', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'
  end
end
