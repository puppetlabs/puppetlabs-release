platform "fedora-f27-x86_64" do |plat|
  plat.servicedir "/usr/lib/systemd/system"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "systemd"

  plat.provision_with "/usr/bin/dnf clean metadata && /usr/bin/dnf install -y --best --allowerasing autoconf automake createrepo rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign"
  plat.install_build_dependencies_with "/usr/bin/dnf install -y --best --allowerasing"
  plat.vmpooler_template "fedora-27-x86_64"
end
