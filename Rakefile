require 'erb'

@name = 'puppetlabs-release'
@debversion = ENV["debversion"] ||= "1.0"
@release = ENV["release"] ||= "11"
@deb_dists = ["jessie", "precise", "squeeze", "trusty", "utopic", "wheezy"]
@signwith = ENV["signwith"] ||= "4BD6EC30"
@nosign ||= ENV["no_sign"]
@signmacros = %{--define "%_gpg_name #{@signwith}"}
@signmacros_el5 = %{--define "%__gpg_sign_cmd %{__gpg} gpg --force-v3-sigs --digest-algo=sha1 --batch --no-verbose --no-armor --passphrase-fd 3 --no-secmem-warning -u %{_gpg_name} -sbo %{__signature_filename} %{__plaintext_filename}"}
@rpm_rsync_url = ENV["rpm_rsync_url"] ||= "#{ENV["USER"]}@yum.puppetlabs.com:/opt/repository/yum"
@deb_rsync_url = ENV["deb_rsync_url"] ||= "#{ENV["USER"]}@apt.puppetlabs.com:/opt/repository/incoming"

@matrix = {
  :el5 => { :dist => 'el', :codename => '5', :version => '5' },
  :el6 => { :dist => 'el', :codename => '6', :version => '6' },
  :el7 => { :dist => 'el', :codename => '7', :version => '7' },
  :f20 => { :dist => 'fedora', :codename => 'f20', :version => '20' },
  :f21 => { :dist => 'fedora', :codename => 'f21', :version => '21' },
}

def get_temp
  `mktemp -d -t tmpXXXXXX`.strip
end

def erb(erbfile,  outfile)
  template = File.read(erbfile)
  message = ERB.new(template, nil, "-")
  output = message.result(binding)
  File.open(outfile, 'w') { |f| f.write output }
  puts "Generated: #{outfile}"
end

def cp_pr(src, dest, options={})
  mandatory = {:preserve => true}
  cp_r(src, dest, options.merge(mandatory))
end

def cp_p(src, dest, options={})
  mandatory = {:preserve => true}
  cp(src, dest, options.merge(mandatory))
end

def mv_f(src, dest, options={})
  force = {:force => true}
  mv(src, dest, options.merge(mandatory))
end

def populate_classvars(dist)
  @version, @dist, @codename = @matrix[dist.to_sym][:version], @matrix[dist.to_sym][:dist],  @matrix[dist.to_sym][:codename]
end

def check_command(cmd)
  %x{which #{cmd}}
  unless $?.success?
    STDERR.puts "#{cmd} command not found...exiting"
    exit 1
  end
end

def build_rpm(dist)
  check_command "rpmbuild"
  populate_classvars dist
  temp = get_temp
  rpm_define = "--define \"%dist .el5\" --define \"%_topdir  #{temp}\" "
  rpm_old_version = '--define "_source_filedigest_algorithm 1" --define "_binary_filedigest_algorithm 1" \
     --define "_binary_payload w9.gzdio" --define "_source_payload w9.gzdio" \
     --define "_default_patch_fuzz 2"'
  args = rpm_define + ' ' + rpm_old_version
  mkdir_p temp
  topdir = "pkg/rpm"
  base = "#{topdir}/#{@dist}/#{@codename}/products"
  mkdir_p "#{base}/SRPMS"
  mkdir_p "#{base}/i386"
  mkdir_p "#{base}/x86_64"
  mkdir_p "#{temp}/SOURCES"
  mkdir_p "#{temp}/SPECS"
  cp_p "files/RPM-GPG-KEY-puppetlabs", "#{temp}/SOURCES/RPM-GPG-KEY-puppetlabs"
  cp_p "files/RPM-GPG-KEY-nightly-puppetlabs", "#{temp}/SOURCES/RPM-GPG-KEY-nightly-puppetlabs"
  erb "templates/redhat/puppetlabs.repo.erb", "#{temp}/SOURCES/puppetlabs.repo"
  erb "templates/redhat/#{@name}.spec.erb", "#{temp}/SPECS/#{@name}.spec"
  sh "rpmbuild -bs #{args} --nodeps #{temp}/SPECS/#{@name}.spec"
  output = `find #{temp} -name *.rpm`
  mv FileList["#{temp}/SRPMS/#{@name}-#{@version}-#{@release}.src.rpm"], "#{base}/SRPMS"
  rm_rf temp
  puts
  puts "Wrote:"
  output.each_line do | line |
    puts "#{`pwd`.strip}/pkg/rpm/#{line.split('/')[-1]}"
  end

  # This package is inherantly noarch, but we're building it on a 64-bit
  # mock and copying it into a 32-bit namespace for distribution.
  mock = "#{@dist == 'el' ? 'pl-el' : 'pl-fedora'}-#{@version}-x86_64"
  sh "mock -r #{mock} #{base}/SRPMS/#{@name}-#{@version}-#{@release}.src.rpm"



  # Is this wrapped in an unless? Yes it is.
  # Why isn't #unless at the end of the command? because it's a very long line.
  # Why are we doing this? Because RHEL7 i386 doesn't exist yet and
  # populating this will just make an empty repo. We'll have to back this
  # out when CentOS drops a 32-bit EL7 release but in the mean time, kludge.
  unless @dist == 'el' && @version == '7'
    cp_pr "/var/lib/mock/#{mock}/result/#{@name}-#{@version}-#{@release}.noarch.rpm", "#{base}/i386/"
  end

  cp_pr "/var/lib/mock/#{mock}/result/#{@name}-#{@version}-#{@release}.noarch.rpm", "#{base}/x86_64/"
  ln_sf "#{base}/i386/#{@name}-#{@version}-#{@release}.noarch.rpm", "#{topdir}/#{@name}-#{@dist}-#{@version}.noarch.rpm"
end

def build_deb(dist)
  check_command "dpkg-buildpackage"
  @dist = dist
  temp = get_temp
  base = "pkg/deb/#{@dist}"
  mkdir_p base
  build_root = "#{temp}/puppetlabs-release_1.0"
  mkdir_p build_root
  cp_p "files/puppetlabs-keyring.gpg", build_root
  cp_p "files/puppetlabs-nightly-keyring.gpg", build_root
  cp_pr "files/deb", "#{build_root}/debian"
  erb "templates/deb/puppetlabs.list.erb", "#{build_root}/puppetlabs.list"
  erb "templates/deb/changelog.erb", "#{build_root}/debian/changelog"
  cd build_root do
    sh "tar czf ../#{@name}_#{@debversion}.orig.tar.gz --exclude 'debian/*' *"
    unless @nosign
      sh "dpkg-buildpackage -k#{@signwith} -sa"
    else
      sh "dpkg-buildpackage -uc -us -sa"
    end
  end
  cp_p FileList[ "#{temp}/*.deb", "#{temp}/*.changes", "#{temp}/*.debian.tar.gz", "#{temp}/*.dsc", "#{temp}/*.orig.tar.gz" ], base
  rm_rf temp
end

def sign_rpm(rpm, type = nil)
  puts "Signing #{type.nil? ? "" : "(using el5 method)"} #{rpm}"
  `./rpmsign-expects#{type.nil? ? "-rpm" : "-el5"} #{rpm} &> /dev/null`
end


desc "Clean package artifacts"
task :clean do
  rm_rf FileList["pkg/*", "rpmsign-expects-*"]
end

desc "Check for a clean git tree"
task :build_environment do
  unless ENV['FORCE'] == '1'
    modified = `git status --porcelain | sed -e '/^\?/d'`
    if modified.split(/\n/).length != 0
      puts <<-HERE
!! ERROR: Your git working directory is not clean. You must
!! remove or commit your changes before you can create a package:

#{`git status | grep '^#'`.chomp}

!! To override this check, set FORCE=1 -- e.g. `rake package:deb FORCE=1`
      HERE
      raise
    end
  end
end

desc "RPM tasks"
namespace :rpm do
  desc "Build all the packages"
  task :all => :build_environment do
    @matrix.each do | k, v |
      build_rpm(k)
    end
  end

  desc "Build just one dist's release package"
  task :single => :build_environment do
    unless ENV["DIST"]
      STDERR.puts "DIST is required"
      exit 1
    end
    build_rpm(ENV["DIST"])
  end

  desc "Ship the packages to the world"
  task :ship => [:check] do
    sh "rsync -avg pkg/rpm/* #{@rpm_rsync_url}"
  end

  desc "Check the RPM signatures"
  task :check do
    unsigned = []

    # Get to the rpms
    Dir["pkg/rpm/**/*"].select {|rpm| File.file?(rpm) }.each do | rpm |
      %x{rpm --checksig #{rpm}}
      unsigned << rpm unless $?.success?
      unless unsigned.empty?
        unsigned.each do |rpm|
          STDERR.puts "#{rpm} is UNSIGNED"
        end
        STDERR.puts "Some rpms are unsigned. They must be signed before they can be shipped."
        exit 1
      end
    end
  end

  desc "Sign the RPMs"
  task :signall do
    # Get the passphrase once
    if @passphrase.nil?
      puts "Passphrase needs to be set. Please enter it."
      STDOUT.flush
      `stty -echo`
      @passphrase = STDIN.gets.chomp
      `stty echo`
      puts ""
    end

    @cur_signmacros = "#{@signmacros} #{@signmacros_el5}"
    erb "templates/rpmsign-expects.erb", "rpmsign-expects-el5"
    chmod 0755, "rpmsign-expects-el5"

    @cur_signmacros = @signmacros
    erb "templates/rpmsign-expects.erb", "rpmsign-expects-rpm"
    chmod 0755, "rpmsign-expects-rpm"

    # Get to the rpms
    Dir["pkg/rpm/**/*"].select {|rpm| File.file?(rpm) }.each do | rpm |
      if rpm.match(/el\/5\//)
        sign_rpm(rpm, :el5)
      else
        sign_rpm(rpm)
      end
    end
  end
end

desc "DEB tasks"
namespace :deb do
  desc "Build one dist's debian release package"
  task :single => :build_environment do
    unless ENV["DIST"]
      STDERR.puts "DIST is required"
      exit 1
    end
    build_deb(ENV["DIST"])
  end

  desc "Build all the debian release packages"
  task :all => :build_environment do
    @deb_dists.each do |dist|
      build_deb(dist)
    end
  end

  desc "Ship the packages to the place"
  task :ship do
    sh "rsync -avg pkg/deb/* #{@deb_rsync_url}"
  end
end

