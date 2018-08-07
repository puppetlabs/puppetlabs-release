component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2018.3.22'

  if platform.is_deb?
    pkg.url "file://files/#{settings[:target_repo]}.list.txt"
    pkg.install_configfile "#{settings[:target_repo]}.list.txt", "/etc/apt/sources.list.d/#{settings[:target_repo]}.list"
    pkg.install do
      "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/#{settings[:target_repo]}.list"
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

    pkg.url "file://files/#{settings[:target_repo]}.repo.txt"
    pkg.install_configfile "#{settings[:target_repo]}.repo.txt", "#{repo_path}/#{settings[:target_repo]}.repo"

    install_hash = ["sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' -e 's|__OS_VERSION__|#{platform.os_version}|g' #{repo_path}/#{settings[:target_repo]}.repo"]

    # The repo definion on sles is invalid unless each gpg key begins with a
    # a '='. This isn't the case for other rpm platforms, so we get to modify
    # the repo file after we install it on sles.
    if platform.is_sles?
      install_hash << "sed -i -e 's|file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet5-release|=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-#{settings[:target_repo]}-release|g' #{repo_path}/#{settings[:target_repo]}.repo"
    end

    pkg.install do
      install_hash
    end
  end
end

