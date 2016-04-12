platform "huaweios-6-powerpc" do |plat|
  plat.servicedir "/etc/init.d"
  plat.defaultdir "/etc/default"
  # HuaweiOS is based on Debian 8 but uses sysv instead of systemd
  plat.servicetype "sysv"
  plat.codename "huaweios"

  plat.apt_repo "http://pl-build-tools.delivery.puppetlabs.net/debian/pl-build-tools-release-jessie.deb"
  plat.provision_with "export DEBIAN_FRONTEND=noninteractive; apt-get update -qq; apt-get install -qy --no-install-recommends build-essential devscripts make quilt pkg-config debhelper rsync fakeroot"
  plat.install_build_dependencies_with "DEBIAN_FRONTEND=noninteractive; apt-get install -qy --no-install-recommends "
  # We don't have a powerpc template so we're using an x86_64 one
  plat.vmpooler_template "debian-8-x86_64"
end
