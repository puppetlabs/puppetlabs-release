platform "fedora-f23-x86_64" do |plat|
  plat.servicedir "/usr/lib/systemd/system"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "systemd"

  plat.provision_with "/usr/bin/dnf install -y autoconf automake createrepo rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign"
  plat.install_build_dependencies_with "/usr/bin/dnf install -y"
  plat.vmpooler_template "fedora-23-x86_64"
end
