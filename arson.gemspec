# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{arson}
  s.version = "2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Colin 'Evaryont' Shea"]
  s.date = %q{2009-04-26}
  s.default_executable = %q{arson}
  s.email = %q{evaryont@saphrix.com}
  s.executables = ["arson"]
  s.files = Dir["bin/**/*"] + Dir["lib/**/*"] + ["README.mkd"]
  s.has_rdoc = true
  s.homepage = %q{http://evaryont.github.com/arson/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{The HOT AUR search helper}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
