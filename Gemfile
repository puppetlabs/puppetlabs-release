source 'https://rubygems.org'

def vanagon_location_for(place)
  git_repo = /^(git[:@][^#]*)#(.*)/
  file_uri = %r{^file:\/\/(.*)}
  version_number = /(\d+\.\d+\.\d+)/
  if place =~ git_repo
    [{ git: Regexp.last_match(1), branch: Regexp.last_match(2), require: false }]
  elsif place =~ file_uri
    ['>= 0', { path: File.expand_path(Regexp.last_match(1)), require: false }]
  elsif place =~ version_number
    [Regexp.last_match(1), { git: 'https://github.com/puppetlabs/vanagon.git', tag: Regexp.last_match(1) }]
  end
end

gem 'json'
gem 'packaging', '~> 0.4', git: 'https://github.com/puppetlabs/packaging.git'
gem 'rake'
# We should use a minimum specific Vanagon verson, but
#  allow it to rev upwards within a given Y release series
gem 'vanagon', *vanagon_location_for(ENV['VANAGON_LOCATION'] || '~> 0.9.3')
