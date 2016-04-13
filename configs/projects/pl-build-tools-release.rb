project 'pl-build-tools-release' do |proj|
  proj.description 'Release packages for the Puppet Labs build tools repository'
  proj.license 'ASL 2.0'
  proj.version '22.0.2'
  proj.release '0'
  proj.vendor 'Puppet Labs <info@puppetlabs.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.noarch
  proj.target_repo ''

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
