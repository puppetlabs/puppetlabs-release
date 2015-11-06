component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2015.03.31'

  if platform.is_deb?
    pkg.url 'file://files/pl-build-tools.list.txt'
    pkg.md5sum 'c9fa2a46a12cc95f536751870a76a87f'
    pkg.install_file 'pl-build-tools.list.txt', '/etc/apt/sources.list.d/pl-build-tools.list'
    pkg.install do
      "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/pl-build-tools.list"
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

    install_cmds = [ "sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' -e 's|__OS_VERSION__|#{platform.os_version}|g' #{repo_path}/pl-build-tools.repo" ]

    if platform.name =~ /el-4/
      install_cmds << "sed -i 's/gpgcheck=1/gpgcheck=0/' #{repo_path}/pl-build-tools.repo"
    end

    pkg.url 'file://files/pl-build-tools.repo.txt'
    pkg.md5sum '154b9edd18c730d88615b64b8b4f0f07'
    pkg.install_file 'pl-build-tools.repo.txt', "#{repo_path}/pl-build-tools.repo"
    pkg.install do
      install_cmds
    end
  end
end

