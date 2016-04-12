component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2015.03.31'

  if platform.is_deb?
    pkg.url 'file://files/puppetlabs-keyring.gpg'
    pkg.md5sum 'a58d53285fa03c59d3b684f1a10855af'
    pkg.install_file 'puppetlabs-keyring.gpg', '/etc/apt/trusted.gpg.d/puppetlabs-pc1-keyring.gpg'
  else
    pkg.url 'file://files/RPM-GPG-KEY-puppetlabs.gpg'
    pkg.md5sum '7b4ed31e1028f921b5c965df0a42e508'
    pkg.install_file 'RPM-GPG-KEY-puppetlabs.gpg', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs-PC1'
  end
end
