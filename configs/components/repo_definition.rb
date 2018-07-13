component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2017.05.05'

  if platform.is_deb?
    pkg.url 'file://files/puppet5-nightly.list.txt'
    pkg.md5sum '53d2e1455bab67b4a49a5d0969ebbb95'
    pkg.install_configfile 'puppet5-nightly.list.txt', '/etc/apt/sources.list.d/puppet5-nightly.list'
    pkg.install do
      "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/puppet5-nightly.list"
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

    pkg.url 'file://files/puppet5-nightly.repo.txt'
    pkg.md5sum 'c5b79dc2f8a13d710a17e5f3ca502376'
    pkg.install_configfile 'puppet5-nightly.repo.txt', "#{repo_path}/puppet5-nightly.repo"

    install_hash = ["sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' -e 's|__OS_VERSION__|#{platform.os_version}|g' #{repo_path}/puppet5-nightly.repo"]

    # The repo definion on sles is invalid unless each gpg key begins with a
    # a '='. This isn't the case for other rpm platforms, so we get to modify
    # the repo file after we install it on sles.
    if platform.is_sles?
      install_hash << "sed -i -e 's|file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet5-release|=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet5-release|g' #{repo_path}/puppet5-nightly.repo"
    end

    pkg.install do
      install_hash
    end
  end
end

