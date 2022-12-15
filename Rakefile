# The 'packaging' gem requires these for configuration information.
# See: https://github.com/puppetlabs/build-data
ENV['TEAM'] = 'release'
ENV['PROJECT_ROOT'] = Dir.pwd

require 'packaging'

Pkg::Util::RakeUtils.load_packaging_tasks

desc 'Create packages from release-file definitions'
task :build do
  projects = Dir.glob('source/projects/*.json').map do |json_file_name|
    File.basename(json_file_name, '.json')
  end.join(' ')

  sh "./ci/create-packages #{projects}"
end

desc 'Sign packages'
task :sign do
   Pkg::Util::RakeUtils.invoke_task('pl:jenkins:sign_all', 'output')
end

desc 'Upload packages to builds and Artifactory'
task :ship do
  Pkg::Util::RakeUtils.invoke_task('pl:jenkins:ship', 'artifacts', 'output')
  Pkg::Util::RakeUtils.invoke_task('pl:jenkins:ship_to_artifactory', 'output')
end

desc 'Clean up build and output directories'
task :clean do
  rm_rf 'build'
  rm_rf 'output'
end
