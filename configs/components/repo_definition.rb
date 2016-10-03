component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2016.10.03'

  if platform.is_deb?
    pkg.url 'file://files/pl-build-tools.list.txt'
    pkg.md5sum 'c9fa2a46a12cc95f536751870a76a87f'
    pkg.install_file 'pl-build-tools.list.txt', '/etc/apt/sources.list.d/pl-build-tools-staging.list'
    pkg.install do
      if platform.is_huaweios?
        # For pl-build-tools, we're using jessie packages cross compiled for powerpc
        "sed -i 's|__CODENAME__|jessie|g' /etc/apt/sources.list.d/pl-build-tools-staging.list"
      else
        "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/pl-build-tools-staging.list"
      end
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

    install_cmds = [ "sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' -e 's|__OS_VERSION__|#{platform.os_version}|g' #{repo_path}/pl-build-tools-staging.repo" ]

    if platform.name =~ /el-4/
      install_cmds << "sed -i 's/gpgcheck=1/gpgcheck=0/' #{repo_path}/pl-build-tools-staging.repo"
    elsif platform.is_sles?
      install_cmds << "sed -i -e 's|file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-build-tools-staging|=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-build-tools-staging|g' #{repo_path}/pl-build-tools-staging.repo"
    end

    pkg.url 'file://files/pl-build-tools.repo.txt'
    pkg.md5sum '154b9edd18c730d88615b64b8b4f0f07'
    pkg.install_file 'pl-build-tools.repo.txt', "#{repo_path}/pl-build-tools-staging.repo"
    pkg.install do
      install_cmds
    end
  end
end

