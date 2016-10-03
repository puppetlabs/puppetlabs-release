component 'gpg_key' do |pkg, settings, platform|
  pkg.version '2016.10.03'

  if platform.is_deb?
    pkg.add_source 'file://files/puppetlabs-keyring.gpg'
    pkg.install_file 'puppetlabs-keyring.gpg', '/etc/apt/trusted.gpg.d/puppetlabs-pc1-keyring.gpg'
  else
    pkg.add_source("file://files/RPM-GPG-KEY-puppetlabs.gpg")
    pkg.add_source("file://files/RPM-GPG-KEY-puppet.asc")
    pkg.add_source("file://files/RPM-GPG-KEY-nightly-puppetlabs")
    pkg.install_file 'RPM-GPG-KEY-puppetlabs.gpg', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs-PC1'
    pkg.install_file 'RPM-GPG-KEY-puppet.asc', '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-PC1'
    pkg.install_file 'RPM-GPG-KEY-nightly-puppetlabs', '/etc/pki/rpm-gpg/RPM-GPG-KEY-nightly-puppetlabs-PC1'

    # SLES doesn't automagically import gpg keys even if they're defined in
    # the repo file. Because of this we need to import the keys in a postinst
    # script. This keeps the sles workflow consistent with other rpm based
    # platforms
    if platform.is_sles?
      if platform.os_version >= "12"
        pkg.add_postinstall_action ["install"],
          ['rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-PC1',
           'rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs-PC1']
      end
    end
  end
end
