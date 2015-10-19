component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2015.09.28'

  if platform.is_deb?
    pkg.url 'file://files/puppetlabs.list.txt'
    pkg.md5sum '53d2e1455bab67b4a49a5d0969ebbb95'
    pkg.install_configfile 'puppetlabs.list.txt', '/etc/apt/sources.list.d/puppetlabs-pc1.list'
    pkg.install do
      "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/puppetlabs-pc1.list"
    end
  else
    # Specifying the repo path as a platform config var is likely the
    # way to go if anything else needs to get added here:
    if platform.is_cisco_wrlinux?
      repo_path = '/etc/yum/repos.d'
    else
      repo_path = '/etc/yum.repos.d'
    end

    pkg.url 'file://files/puppetlabs.repo.txt'
    pkg.md5sum 'c5b79dc2f8a13d710a17e5f3ca502376'
    pkg.install_configfile 'puppetlabs.repo.txt', "#{repo_path}/puppetlabs-pc1.repo"
    pkg.install do
      "sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' -e 's|__OS_VERSION__|#{platform.os_version}|g' #{repo_path}/puppetlabs-pc1.repo"
    end
  end
end

