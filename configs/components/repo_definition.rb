component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2016.11.03'

  if platform.is_deb?
    pkg.url 'file://files/test-tools.list.txt'
    pkg.md5sum 'ba0d40ea589a00017a412d70bacc6ff5'
    pkg.install_file 'test-tools.list.txt', '/etc/apt/sources.list.d/test-tools.list'
    pkg.install do
      if platform.is_huaweios?
        # For test-tools, we're using jessie packages cross compiled for powerpc
        "sed -i 's|__CODENAME__|jessie|g' /etc/apt/sources.list.d/test-tools.list"
      else
        "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/test-tools.list"
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

    install_cmds = [ "sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' -e 's|__OS_VERSION__|#{platform.os_version}|g' #{repo_path}/test-tools.repo" ]

    if platform.name =~ /el-4/
      install_cmds << "sed -i 's/gpgcheck=1/gpgcheck=0/' #{repo_path}/test-tools.repo"
    elsif platform.is_sles?
      install_cmds << "sed -i -e 's|file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-test-tools|=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-test-tools|g' #{repo_path}/test-tools.repo"
    end

    pkg.url 'file://files/test-tools.repo.txt'
    pkg.md5sum 'a33abac3098b49ee2f0d8c68ff97e670'
    pkg.install_file 'test-tools.repo.txt', "#{repo_path}/test-tools.repo"
    pkg.install do
      install_cmds
    end
  end
end

