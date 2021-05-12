platform "el-8-ppc64le" do |plat|
    plat.servicedir "/usr/lib/systemd/system"
    plat.defaultdir "/etc/sysconfig"
    plat.servicetype "systemd"
  
    plat.provision_with "yum install --assumeyes autoconf automake createrepo rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign"
    plat.install_build_dependencies_with "yum install --assumeyes"
    plat.vmpooler_template "redhat-8-power8"
  end
  
