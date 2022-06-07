platform "fedora-35-x86_64" do |plat|
    plat.servicedir "/usr/lib/systemd/system"
    plat.defaultdir "/etc/sysconfig"
    plat.servicetype "systemd"
    plat.dist "fc35"

    plat.provision_with "dnf clean metadata && dnf install -y autoconf automake createrepo rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign"
    plat.install_build_dependencies_with "dnf install -y"
    plat.vmpooler_template "fedora-35-x86_64"
  end
