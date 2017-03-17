component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2016.10.05'

  if platform.is_deb?
    pkg.add_source 'file://files/puppet-keyring.gpg'
    pkg.install_file 'puppet-keyring.gpg', '/etc/apt/trusted.gpg.d/puppet-keyring.gpg'
  else
    pkg.add_source("file://files/RPM-GPG-KEY-puppetlabs.gpg")
    pkg.add_source("file://files/RPM-GPG-KEY-puppet.asc")
    pkg.add_source("file://files/RPM-GPG-KEY-nightly-puppetlabs")
    pkg.install_file 'RPM-GPG-KEY-puppetlabs.gpg', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs-release'
    pkg.install_file 'RPM-GPG-KEY-puppet.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release'
    pkg.install_file 'RPM-GPG-KEY-nightly-puppetlabs', '/etc/pki/rpm-gpg/RPM-GPG-KEY-nightly-puppetlabs-release'

  end
end
