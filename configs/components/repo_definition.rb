component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2017.03.03'

  if platform.is_deb?
    pkg.url 'file://files/puppet.list.txt'
    pkg.md5sum '53d2e1455bab67b4a49a5d0969ebbb95'
    pkg.install_configfile 'puppet.list.txt', '/etc/apt/sources.list.d/puppet.list'
  if platform.name =~ /^ubuntu-16.10/
    # Ubuntu 16.10 shipped with a puppet-agent package that was versioned based
    # on the included version of puppet. This means the distro package would
    # override Puppet Inc's puppet-agent AIO package version. We are working
    # around this by pinning our puppet-agent package to a higher priority in
    # this preferences config fragment:
    pkg.add_source 'file://files/puppet-agent-pin-1000.txt', sum: '713257941eb9e3fae798d4faebd1a995'
    pkg.install_configfile 'puppet-agent-pin-1000.txt', '/etc/apt/preferences.d/puppet-agent-pin-1000'
  end
    pkg.install do
      "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/puppet.list"
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

    pkg.url 'file://files/puppet.repo.txt'
    pkg.md5sum 'c5b79dc2f8a13d710a17e5f3ca502376'
    pkg.install_configfile 'puppet.repo.txt', "#{repo_path}/puppet.repo"

    install_hash = ["sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' -e 's|__OS_VERSION__|#{platform.os_version}|g' #{repo_path}/puppet.repo"]

    # The repo definion on sles is invalid unless each gpg key begins with a
    # a '='. This isn't the case for other rpm platforms, so we get to modify
    # the repo file after we install it on sles.
    if platform.is_sles?
      install_hash << "sed -i -e 's|file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release|=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-release|g' #{repo_path}/puppet.repo"
    end

    pkg.install do
      install_hash
    end
  end
end

