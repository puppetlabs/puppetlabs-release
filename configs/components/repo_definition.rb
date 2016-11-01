component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2016.11.01'

  if platform.is_deb?
    pkg.url 'file://files/internal-tools.list.txt'
    pkg.md5sum '00cedb4c1d6eeda38c0a6426530b882d'
    pkg.install_file 'internal-tools.list.txt', '/etc/apt/sources.list.d/internal-tools.list'
    pkg.install do
      if platform.is_huaweios?
        # For internal-tools, we're using jessie packages cross compiled for powerpc
        "sed -i 's|__CODENAME__|jessie|g' /etc/apt/sources.list.d/internal-tools.list"
      else
        "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/internal-tools.list"
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

    install_cmds = [ "sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' -e 's|__OS_VERSION__|#{platform.os_version}|g' #{repo_path}/internal-tools.repo" ]

    if platform.name =~ /el-4/
      install_cmds << "sed -i 's/gpgcheck=1/gpgcheck=0/' #{repo_path}/internal-tools.repo"
    elsif platform.is_sles?
      install_cmds << "sed -i -e 's|file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-build-tools|=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-build-tools|g' #{repo_path}/internal-tools.repo"
    end

    pkg.url 'file://files/internal-tools.repo.txt'
    pkg.md5sum '3fc4342087a2b536b883297061a8ccd7'
    pkg.install_file 'internal-tools.repo.txt', "#{repo_path}/internal-tools.repo"
    pkg.install do
      install_cmds
    end
  end
end

