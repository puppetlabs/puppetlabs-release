#!/usr/bin/env ruby

require "English"
require "erb"
require "tmpdir"

RAKE_ROOT = File.expand_path(File.dirname(__FILE__))

begin
    load File.join(RAKE_ROOT, 'ext', 'packaging', 'packaging.rake')
rescue LoadError
end

build_defs_file = File.join(RAKE_ROOT, 'ext', 'build_defaults.yaml')
if File.exist?(build_defs_file)
  begin
    require 'yaml'
    @build_defaults ||= YAML.load_file(build_defs_file)
  rescue Exception => e
    STDERR.puts "Unable to load yaml from #{build_defs_file}:"
    raise e
  end
  @packaging_url  = @build_defaults['packaging_url']
  @packaging_repo = @build_defaults['packaging_repo']
  raise "Could not find packaging url in #{build_defs_file}" if @packaging_url.nil?
  raise "Could not find packaging repo in #{build_defs_file}" if @packaging_repo.nil?

  namespace :package do
 #   desc "Bootstrap packaging automation, e.g. clone into packaging repo"
    task :bootstrap do
      if File.exist?(File.join(RAKE_ROOT, "ext", @packaging_repo))
        puts "It looks like you already have ext/#{@packaging_repo}. If you don't like it, blow it away with package:implode."
      else
        cd File.join(RAKE_ROOT, 'ext') do
          %x{git clone #{@packaging_url}}
        end
      end
    end
 #   desc "Remove all cloned packaging automation"
    task :implode do
      rm_rf File.join(RAKE_ROOT, "ext", @packaging_repo)
    end
  end
end

@name = "puppetlabs-release"
@debversion = ENV["debversion"] ||= "1.1"
# We have to set this version to be so high because we were previously using
# the platform version to define the package version. As a result, 21 from
# fedora 21 ended up being the latest version. Lame! So, in order to build
# a standard release package with consistent versions across platforms, we
# get to set this version to 22. Blarg.
@rpmversion = ENV["rpmversion"] ||= "22.0"
@release = ENV["release"] ||= "1"
@deb_dists = %w[jessie precise squeeze trusty utopic wheezy]
@signwith = ENV["signwith"] ||= "4BD6EC30"
@nosign ||= ENV["no_sign"]
@rpm_rsync_url = ENV["rpm_rsync_url"] ||= "#{ENV["USER"]}@weth.delivery.puppetlabs.net:/opt/repository/yum"
@deb_rsync_url = ENV["deb_rsync_url"] ||= "#{ENV["USER"]}@weth.delivery.puppetlabs.net:/opt/tools/freight/apt"

@matrix = {
  el5: { dist: "el", codename: "5", plat_version: "5" },
  el6: { dist: "el", codename: "6", plat_version: "6" },
  el7: { dist: "el", codename: "7", plat_version: "7" },
  f20: { dist: "fedora", codename: "f20", plat_version: "20" },
  f21: { dist: "fedora", codename: "f21", plat_version: "21" }
}

def tempdir
  Dir.mktmpdir
end

def erb(erbfile, outfile)
  template = File.read(erbfile)
  message = ERB.new(template, nil, "-")
  output = message.result(binding)
  File.open(outfile, "w") { |f| f.write output }
  puts "Generated: #{outfile}"
end

def cp_pr(src, dest, options = {})
  mandatory = { preserve: true }
  cp_r(src, dest, options.merge(mandatory))
end

def cp_p(src, dest, options = {})
  mandatory = { preserve: true }
  cp(src, dest, options.merge(mandatory))
end

def mv_f(src, dest, options = {})
  force = { force: true }
  mv(src, dest, options.merge(force))
end

def populate_classvars(dist)
  @dist = @matrix[dist.to_sym][:dist]
  @codename = @matrix[dist.to_sym][:codename]
  @plat_version = @matrix[dist.to_sym][:plat_version]
end

def check_command(cmd)
  `which #{cmd}`
  unless $CHILD_STATUS.success?
    $stderr.puts "#{cmd} command not found...exiting"
    exit 1
  end
end

def build_rpm(dist)
  check_command "rpmbuild"
  populate_classvars dist
  temp = tempdir
  rpm_define = "--define \"%dist .el5\" --define \"%_topdir  #{temp}\" "
  rpm_old_version = '--define "_source_filedigest_algorithm 1" --define "_binary_filedigest_algorithm 1" \
     --define "_binary_payload w9.gzdio" --define "_source_payload w9.gzdio" \
     --define "_default_patch_fuzz 2"'
  args = rpm_define + " " + rpm_old_version
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
  cp_p "files/RPM-GPG-KEY-puppet.asc", "#{temp}/SOURCES/RPM-GPG-KEY-puppet.asc"
  erb "templates/redhat/puppetlabs.repo.erb", "#{temp}/SOURCES/puppetlabs.repo"
  erb "templates/redhat/#{@name}.spec.erb", "#{temp}/SPECS/#{@name}.spec"
  sh "rpmbuild -bs #{args} --nodeps #{temp}/SPECS/#{@name}.spec"
  output = `find #{temp} -name *.rpm`
  mv FileList["#{temp}/SRPMS/#{@name}-#{@rpmversion}-#{@release}.src.rpm"], "#{base}/SRPMS"
  rm_rf temp
  puts
  puts "Wrote:"
  output.each_line do |line|
    puts "#{Dir.pwd}/pkg/#{line.split("/")[-1]}"
  end

  # This package is inherantly noarch, but we're building it on a 64-bit
  # mock and copying it into a 32-bit namespace for distribution.
  mock = "#{@dist == "el" ? "pl-el" : "pl-fedora"}-#{@plat_version}-x86_64"
  sh "mock -r #{mock} #{base}/SRPMS/#{@name}-#{@rpmversion}-#{@release}.src.rpm"

  # Is this wrapped in an unless? Yes it is.
  # Why isn't #unless at the end of the command? because it's a very long line.
  # Why are we doing this? Because RHEL7 i386 doesn't exist yet and
  # populating this will just make an empty repo. We'll have to back this
  # out when CentOS drops a 32-bit EL7 release but in the mean time, kludge.
  unless @dist == "el" && @plat_version == "7"
    cp_pr "/var/lib/mock/#{mock}/result/#{@name}-#{@rpmversion}-#{@release}.noarch.rpm", "#{base}/i386/"
  end

  cp_pr "/var/lib/mock/#{mock}/result/#{@name}-#{@rpmversion}-#{@release}.noarch.rpm", "#{base}/x86_64/"
end

def build_deb(dist)
  check_command "dpkg-buildpackage"
  @dist = dist
  temp = tempdir
  base = "pkg/deb/#{@dist}"
  mkdir_p base
  build_root = "#{temp}/puppetlabs-release_#{@debversion}"
  mkdir_p build_root
  cp_p "files/puppetlabs-keyring.gpg", build_root
  cp_p "files/puppetlabs-nightly-keyring.gpg", build_root
  cp_pr "files/deb", "#{build_root}/debian"
  erb "templates/deb/puppetlabs.list.erb", "#{build_root}/puppetlabs.list"
  erb "templates/deb/changelog.erb", "#{build_root}/debian/changelog"
  cd build_root do
    sh "tar czf ../#{@name}_#{@debversion}.orig.tar.gz --exclude 'debian/*' *"
    if @nosign
      sh "dpkg-buildpackage -uc -us -sa"
    else
      sh "dpkg-buildpackage -k#{@signwith} -sa"
    end
  end
  cp_p FileList["#{temp}/*.deb", "#{temp}/*.changes", "#{temp}/*.debian.tar.gz", "#{temp}/*.dsc", "#{temp}/*.orig.tar.gz"], base
  rm_rf temp
end

desc "Clean package artifacts"
task :clean do
  rm_rf FileList["pkg/*"]
end

desc "Check for a clean git tree"
task :build_environment do
  unless ENV["FORCE"] == "1"
    modified = `git status --porcelain | sed -e '/^\?/d'`
    unless modified.split(/\n/).empty?
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
  task all: :build_environment do
    @matrix.each do |k, _v|
      build_rpm(k)
    end
  end

  desc "Build just one dist's release package"
  task single: :build_environment do
    unless ENV["DIST"]
      $stderr.puts "DIST is required"
      exit 1
    end
    build_rpm(ENV["DIST"])
  end

  desc "Ship the packages to the world"
  task ship: :build_environment do
    cmd = %W[
      rsync
      --recursive
      --hard-links
      --links
      --verbose
      --omit-dir-times
      --no-perms
      --no-owner
      --no-group
      pkg/rpm/*
      #{@rpm_rsync_url}
    ].join(" ")

    sh cmd
  end
end

desc "DEB tasks"
namespace :deb do
  desc "Build one dist's debian release package"
  task single: :build_environment do
    unless ENV["DIST"]
      $stderr.puts "DIST is required"
      exit 1
    end
    build_deb(ENV["DIST"])
  end

  desc "Build all the debian release packages"
  task all: :build_environment do
    @deb_dists.each do |dist|
      build_deb(dist)
    end
  end

  desc "Ship the packages to the place"
  task :ship do
    cmd = %W[
      rsync
      --recursive
      --hard-links
      --links
      --verbose
      --omit-dir-times
      --no-perms
      --no-owner
      --no-group
      pkg/deb/*
      #{@deb_rsync_url}
    ].join(" ")

    sh cmd
  end
end
