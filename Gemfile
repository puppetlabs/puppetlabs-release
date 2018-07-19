source 'https://rubygems.org'

def location_for(place)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [{ :git => $1, :branch => $2, :require => false }]
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

gem 'json'
gem 'packaging', *location_for(ENV['PACKAGING_LOCATION'] || '~> 0.99.8')
gem 'releng_metadata', :source => 'https://artifactory.delivery.puppetlabs.net/artifactory/api/gems/rubygems/'
gem 'rake'
# We should use a minimum specific Vanagon verson, but
#  allow it to rev upwards within a given Y release series
gem 'vanagon', *location_for(ENV['VANAGON_LOCATION'] || '~> 0.14.1')
