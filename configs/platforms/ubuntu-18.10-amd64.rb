platform "ubuntu-18.10-amd64" do |plat|
  plat.servicedir "/usr/lib/systemd/system"
  plat.defaultdir "/etc/default"
  plat.servicetype "systemd"
  plat.codename "cosmic"

  plat.provision_with "export DEBIAN_FRONTEND=noninteractive; apt-get update -qq; apt-get install -qy --no-install-recommends build-essential devscripts make quilt pkg-config debhelper rsync fakeroot"
  plat.install_build_dependencies_with "DEBIAN_FRONTEND=noninteractive; apt-get install -qy --no-install-recommends "
  plat.vmpooler_template "ubuntu-1810-x86_64"
end
