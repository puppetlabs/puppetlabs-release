component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2021.2.4'

  if platform.is_deb?
    pkg.add_source 'file://files/keyring.gpg'
    pkg.install_file 'keyring.gpg', "/etc/apt/trusted.gpg.d/#{settings[:target_repo]}-keyring.gpg"
  else
    pkg.add_source("file://files/RPM-GPG-KEY-puppet.asc")
    pkg.add_source("file://files/RPM-GPG-KEY-puppet-2025-04-06.pub")
    pkg.install_file 'RPM-GPG-KEY-puppet.asc', "/etc/pki/rpm-gpg/RPM-GPG-KEY-#{settings[:target_repo]}-release"
    pkg.install_file 'RPM-GPG-KEY-puppet-2025-04-06.pub', "/etc/pki/rpm-gpg/RPM-GPG-KEY-2025-04-06-#{settings[:target_repo]}-release"
  end
end
