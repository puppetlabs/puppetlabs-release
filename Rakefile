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
  Dir.glob('source/projects/*.json').each do |json_file_name|
    project_name = File.basename(json_file_name, '.json')
    Dir.chdir(project_name) do
      Pkg::Util::RakeUtils.invoke_task('pl:jenkins:sign_all', 'output')
    end
  end
end

desc 'Upload packages to builds and Artifactory'
task :ship do
  Dir.glob('source/projects/*.json').each do |json_file_name|
    project_name = File.basename(json_file_name, '.json')
    ENV['PROJECT_OVERRIDE'] = project_name
    Dir.chdir(project_name) do
      Pkg::Util::RakeUtils.invoke_task('pl:jenkins:ship', 'artifacts', 'output')
      Pkg::Util::RakeUtils.invoke_task('pl:jenkins:ship_to_artifactory', 'output')
    end
  end
end

desc 'Clean up build and output directories'
task :clean do
  rm_rf 'build'
  Dir.glob('source/projects/*.json').each do |json_file_name|
    project_name = File.basename(json_file_name, '.json')
    rm_rf project_name
  end
end
