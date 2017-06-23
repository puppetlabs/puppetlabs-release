component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2017.06.22'

  if platform.is_deb?
    pkg.add_source 'file://files/puppet5.list.txt'
    pkg.install_configfile 'puppet5.list.txt', '/etc/apt/sources.list.d/puppet5.list'
    pkg.install do
      "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/puppet5.list"
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

    pkg.add_source 'file://files/puppet5.repo.txt'
    pkg.install_configfile 'puppet5.repo.txt', "#{repo_path}/puppet5.repo"

    pkg.install do
      "sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' -e 's|__OS_VERSION__|#{platform.os_version}|g' #{repo_path}/puppet5.repo"
    end
  end
end

