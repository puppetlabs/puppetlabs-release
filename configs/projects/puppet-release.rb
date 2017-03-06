project 'puppet-release' do |proj|
  proj.description 'Release packages for the Puppet repository'
  proj.release '1'
  proj.license 'ASL 2.0'
  proj.version '1.0.0'
  proj.vendor 'Puppet Labs <info@puppetlabs.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.target_repo 'puppet'
  proj.noarch

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
