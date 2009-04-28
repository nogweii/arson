begin; require 'rubygems'; rescue LoadError; end

require 'rake'

begin
	require 'jeweler'
	Jeweler::Tasks.new do |gemspec|
		gemspec.name = 'arson'
		gemspec.author = "Colin 'Evaryont' Shea"
		gemspec.summary = "The HOT AUR search helper"
		gemspec.description = gemspec.summary
		gemspec.email = 'evaryont@saphrix.com'
		gemspec.homepage = 'http://evaryont.github.com/arson/'
		gemspec.platform = Gem::Platform::RUBY
		gemspec.files = `git ls-files`.split("\n").sort
		gemspec.has_rdoc = true
		gemspec.require_path = 'lib'
		gemspec.bindir = "bin"
		gemspec.executables = ["arson"]

		gemspec.add_dependency('json', '>= 1.1.3')
		gemspec.add_dependency('facets', '>= 2.5.1')
	end
rescue LoadError
	puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

namespace :version do
	desc "Writes the version to lib/#{}/version.rb"
	task :write do
	end
end
