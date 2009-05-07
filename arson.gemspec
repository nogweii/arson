# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{arson}
  s.version = "2.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Colin 'Evaryont' Shea"]
  s.date = %q{2009-05-07}
  s.default_executable = %q{arson}
  s.description = %q{The HOT AUR search helper}
  s.email = %q{evaryont@saphrix.com}
  s.executables = ["arson"]
  s.files = ["PKGBUILD", "README.mkd", "Rakefile", "VERSION.yml", "arson.gemspec", "bin/arson", "lib/arson.rb", "lib/arson/colorful.rb", "lib/arson/download.rb", "lib/arson/search.rb", "lib/arson/upgrade.rb", "lib/arson/version.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://evaryont.github.com/arson/}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{The HOT AUR search helper}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 1.1.3"])
      s.add_runtime_dependency(%q<facets>, [">= 2.5.1"])
    else
      s.add_dependency(%q<json>, [">= 1.1.3"])
      s.add_dependency(%q<facets>, [">= 2.5.1"])
    end
  else
    s.add_dependency(%q<json>, [">= 1.1.3"])
    s.add_dependency(%q<facets>, [">= 2.5.1"])
  end
end
