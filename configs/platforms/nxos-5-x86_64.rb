platform "nxos-5-x86_64" do |plat|
  plat.servicedir "/etc/init.d"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "sysv"

  plat.yum_repo "http://pl-build-tools.delivery.puppetlabs.net/yum/nxos/1/x86_64/pl-build-tools-nxos-1.repo"
  plat.provision_with "yum install -y autoconf automake createrepo rsync gcc make rpm-build rpm-libs yum-utils;yum update -y pkgconfig"
  plat.install_build_dependencies_with "yum install -y"
  plat.vcloud_name "nxos-5-x86_64"
end
