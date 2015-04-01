project 'puppetlabs-release-pc1' do |proj|
  proj.description 'Release packages for the Puppet Labs PC1 repository'
  proj.license 'ASL 2.0'
  proj.version '1.2.3'
  proj.vendor 'Puppet Labs <info@puppetlabs.com>'
  proj.homepage 'https://www.puppetlabs.com'

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
