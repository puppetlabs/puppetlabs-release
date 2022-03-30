component 'repo_definition' do |pkg, settings, platform|
  pkg.version '2020.06.02'

  os_fixup = nil
  target_repo = settings[:target_repo]

  # Some awkward casing here because of the inconsistent layout we have
  destination_server = 'yum.puppetlabs.com'
  destination_server = 'nightlies.puppet.com' if target_repo =~ /-nightly$/

  case
  when platform.is_deb?
    destination_server = 'apt.puppetlabs.com' unless target_repo =~ /-nightly$/
    url = "file://files/#{destination_server}/#{target_repo}.list.txt"
    install_configfile = [
      "#{target_repo}.list.txt",
      "/etc/apt/sources.list.d/#{target_repo}.list"
    ]
    os_fixup = [
      "sed -i 's|__CODENAME__|#{platform.codename}|g' "\
      "/etc/apt/sources.list.d/#{target_repo}.list"
    ]
  when platform.is_sles?
    url = "file://files/#{destination_server}/#{target_repo}.sles.txt"
    repo_path = '/etc/zypp/repos.d'
    install_configfile = [
      "#{target_repo}.sles.txt",
      "#{repo_path}/#{target_repo}.repo"
    ]
  when platform.is_cisco_wrlinux?
    url = "file://files/#{destination_server}/#{target_repo}.repo.txt"
    repo_path = '/etc/yum/repos.d'
    install_configfile = [
      "#{target_repo}.repo.txt",
      "#{repo_path}/#{target_repo}.repo"
    ]
  else
    # centos, redhat, fedora
    url = "file://files/#{destination_server}/#{target_repo}.repo.txt"
    repo_path = '/etc/yum.repos.d'
    install_configfile = [
      "#{target_repo}.repo.txt",
      "#{repo_path}/#{target_repo}.repo"
    ]
  end

  if os_fixup.nil?
    # Default sed-fu for setting os information in the .repo file
    # Need to defer this setting to the end because of 'repo_path'
    os_fixup = [
      "sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' "\
      "-e 's|__OS_VERSION__|#{platform.os_version}|g' "\
      "#{repo_path}/#{target_repo}.repo"
    ]
  end

  pkg.url url
  pkg.install_configfile(*install_configfile)
  pkg.install { os_fixup }
end
