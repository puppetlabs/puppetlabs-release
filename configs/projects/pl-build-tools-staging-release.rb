project 'pl-build-tools-staging-release' do |proj|
  proj.description 'Release packages for the Puppet build tools staging repository'
  proj.license 'ASL 2.0'
  proj.version '1.1'
  proj.release '1'
  proj.vendor 'Puppet Inc <info@puppet.com>'
  proj.homepage 'https://www.puppet.com'
  proj.noarch
  proj.target_repo ''

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
