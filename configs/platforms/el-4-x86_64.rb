platform "el-4-x86_64" do |plat|
  plat.servicedir "/etc/rc.d/init.d"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "sysv"

  plat.provision_with "yum install -y autoconf automake createrepo rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign rpm-build"
  plat.install_build_dependencies_with "yum install -y"
  plat.vmpooler_template "centos-4-x86_64"
end
