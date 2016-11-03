project 'test-tools-release' do |proj|
  proj.description 'Release packages for the Puppet Labs test tools repository'
  proj.license 'ASL 2.0'
  proj.version '1.0.0'
  proj.release '1'
  proj.vendor 'Puppet Labs <info@puppetlabs.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.noarch
  proj.target_repo ''

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
