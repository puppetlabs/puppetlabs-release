component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2017.06.22'

  if platform.is_deb?
    pkg.add_source 'file://files/puppet-nightly.list.txt'
    pkg.install_configfile 'puppet-nightly.list.txt', '/etc/apt/sources.list.d/puppet-nightly.list'
    pkg.install do
      "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/puppet-nightly.list"
    end
  else
    # Specifying the repo path as a platform config var is likely the
    # way to go if anything else needs to get added here:
    if platform.is_cisco_wrlinux?
      repo_path = '/etc/yum/repos.d'
    elsif platform.is_sles?
      repo_path = '/etc/zypp/repos.d'
    else
      repo_path = '/etc/yum.repos.d'
    end

    pkg.add_source 'file://files/puppet-nightly.repo.txt'
    pkg.install_configfile 'puppet-nightly.repo.txt', "#{repo_path}/puppet-nightly.repo"

    install_hash = ["sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' -e 's|__OS_VERSION__|#{platform.os_version}|g' #{repo_path}/puppet-nightly.repo"]

    # The repo definion on sles is invalid unless each gpg key begins with a
    # a '='. This isn't the case for other rpm platforms, so we get to modify
    # the repo file after we install it on sles.
    if platform.is_sles?
      install_hash << "sed -i -e 's|file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release|=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release|g' #{repo_path}/puppet-nightly.repo"
    end

    pkg.install do
      install_hash
    end
  end
end

