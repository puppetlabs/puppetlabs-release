platform "el-4-x86_64" do |plat|
  plat.servicedir "/etc/rc.d/init.d"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "sysv"

  plat.provision_with "yum install -y --nogpgcheck autoconf automake createrepo rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign rpm-build; echo '[build-tools]\nname=build-tools\nbaseurl=http://enterprise.delivery.puppetlabs.net/build-tools/el/4/$basearch\ngpgcheck=0' > /etc/yum.repos.d/build-tools.repo"
  plat.install_build_dependencies_with "yum install -y --nogpgcheck"
  plat.vcloud_name "centos-4-x86_64"
end
