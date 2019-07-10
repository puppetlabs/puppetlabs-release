project 'puppetlabs-release-pc1' do |proj|
  proj.description 'Release packages for the end-of-life Puppet Labs PC1 repository'
  proj.release '2'
  proj.license 'ASL 2.0'
  proj.version '2.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.target_repo 'PC1'
  proj.noarch

  proj.component 'gpg_key'
  proj.component 'repo_definition'
end
