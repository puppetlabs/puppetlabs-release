component 'repos_puppet_com' do |pkg, settings, platform|
  pkg.version '2021.09.13'

  puppet_product = settings[:puppet_product]
  apt_component = settings[:apt_component]

  package_tag = "#{puppet_product}-#{apt_component}.list"
  template_name = "#{package_tag}.template"
  install_path = "/etc/apt/sources.list.d/#{package_tag}"

  template_location = "file://files/apt.repos.puppet.com/#{template_name}"
  install_configfile = %W[#{template_name} #{install_path}]

  os_fixup = [
    "sed -i 's|__CODENAME__|#{platform.codename}|g' #{install_path}"
  ]

  ### Not yet implemented

  # when platform.is_sles?
  #   url = "file://files/#{settings[:target_repo]}.sles.txt"
  #   repo_path = '/etc/zypp/repos.d'
  #   install_configfile = [
  #     "#{settings[:target_repo]}.sles.txt",
  #     "#{repo_path}/#{settings[:target_repo]}.repo"
  #   ]
  # else
  #   # centos, redhat, fedora
  #   url = "file://files/#{settings[:target_repo]}.repo.txt"
  #   repo_path = '/etc/yum.repos.d'
  #   install_configfile = [
  #     "#{settings[:target_repo]}.repo.txt",
  #     "#{repo_path}/#{settings[:target_repo]}.repo"
  #   ]
  # end

  # if os_fixup.nil?
  #   # Default sed-fu for setting os information in the .repo file
  #   # Need to defer this setting to the end because of 'repo_path'
  #   os_fixup = [
  #     "sed -i -e 's|__OS_NAME__|#{platform.os_name}|g' "\
  #     "-e 's|__OS_VERSION__|#{platform.os_version}|g' "\
  #     "#{repo_path}/#{settings[:target_repo]}.repo"
  #   ]
  # end

  pkg.url template_location
  pkg.install_configfile(*install_configfile)
  pkg.install { os_fixup }
end
