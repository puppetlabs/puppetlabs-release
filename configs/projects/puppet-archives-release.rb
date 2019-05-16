project 'puppet-archives-release' do |proj|
  proj.description 'Release packages for the end-of-life Puppet repository'
  proj.release '1'
  proj.license 'ASL 2.0'
  proj.version '1.0.0'
  proj.vendor 'Puppet, Inc. <release@puppet.com>'
  proj.homepage 'https://www.puppetlabs.com'
  proj.noarch

  proj.component 'gpg_key'
  proj.component 'archive_repo_definition'
end
