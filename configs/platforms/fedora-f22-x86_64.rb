platform "fedora-f22-x86_64" do |plat|
  plat.servicedir "/usr/lib/systemd/system"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "systemd"

  plat.provision_with "dnf install -y autoconf automake createrepo rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign"
  plat.yum_repo "http://pl-build-tools.delivery.puppetlabs.net/yum/fedora/22/x86_64/pl-build-tools-release-22.0.0-1.fedoraf22.noarch.rpm"
  plat.install_build_dependencies_with "dnf install -y"
  plat.vmpooler_template "fedora-22-x86_64"
end
