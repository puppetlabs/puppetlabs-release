component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2020.06.01'

  # Default sed-fu for setting os information in the .repo file
  os_fixup = [
    "sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' "\
    "-e 's|__OS_VERSION__|#{platform.os_version}|g' "\
    "#{repo_path}/#{settings[:target_repo]}.repo"
  ]

  case
  when platform.is_deb?
    url = "file://files/#{settings[:target_repo]}.list.txt"
    install_configfile = [
      "#{settings[:target_repo]}.list.txt",
      "/etc/apt/sources.list.d/#{settings[:target_repo]}.list"
    ]
    os_fixup = [
      "sed -i 's|__CODENAME__|#{platform.codename}|g' "\
      "/etc/apt/sources.list.d/#{settings[:target_repo]}.list"
    ]
  when platform.is_sles?
    url = "file://files/#{settings[:target_repo]}.sles.txt"
    repo_path = '/etc/zypp/repos.d'
    install_configfile = [
      "#{settings[:target_repo]}.sles.txt",
      "#{repo_path}/#{settings[:target_repo]}.repo"
    ]
  when platform.is_cisco_wrlinux?
    url = "file://files/#{settings[:target_repo]}.repo.txt"
    repo_path = '/etc/yum/repos.d'
    install_configfile = [
      "#{settings[:target_repo]}.repo.txt",
      "#{repo_path}/#{settings[:target_repo]}.repo"
    ]
  else
    # centos, redhat, fedora
    url = "file://files/#{settings[:target_repo]}.repo.txt"
    repo_path = '/etc/yum.repos.d'
    install_configfile = [
      "#{settings[:target_repo]}.repo.txt",
      "#{repo_path}/#{settings[:target_repo]}.repo"
    ]
  end

  pkg.url url
  pkg.install_configfile *install_configfile
  pkg.install do
    os_fixup
  end
end
