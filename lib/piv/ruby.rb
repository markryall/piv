require 'piv'

module Piv::Ruby
  include Piv

  def init_ruby name
    directory "lib/#{name}"
    directory 'spec' do
      directory name
      file 'spec_helper.rb'
    end
    file '.gemtest'
    file 'Rakefile'
    file 'Gemfile', <<EOF
source 'http://rubygems.org'
gem 'rspec'
EOF
    file 'README.rdoc', <<EOF
= #{name}

a THING

== rationale

* because THINGS are just better this way
EOF
    file 'HISTORY.rdoc'
    file 'MIT-LICENSE', license
  end

  def generate_destroy *names
    rm "lib/#{names.join '/'}.rb"
    rm "spec/#{names.join '/'}_spec.rb"
  end

  def generate_class *names
    generate_ruby 'class', names
  end

  def generate_module *names
    generate_ruby 'module', names
  end

  def generate_gem name
    file 'gemspec', %{
Gem::Specification.new do |spec|
  spec.name = '#{name}'
  spec.version = '0.0.1'
  spec.summary = 'SUMMARY'
  spec.description = <<-EOF
DESCRIPTION
EOF
  spec.authors << 'YOUR NAME'
  spec.email = 'YOUR EMAIL'
  spec.homepage = 'http://HOMEPAGE'
  spec.files = Dir['lib/**/*'] + Dir['spec/**/*'] + Dir['bin/*'] + ['README.rdoc', 'MIT-LICENSE', 'HISTORY.rdoc', 'Rakefile', '.gemtest']
  spec.executables << 'EXECUTABLE'

  spec.add_development_dependency 'rake', '~>0.8'
  spec.add_development_dependency 'gemesis', '~>0'
  spec.add_development_dependency 'rspec', '~>2'
end
}

  end
private
  def generate_ruby thing, names
    name, dirs = names.last, names.slice(0...-1)
    directory ['lib', *dirs] do
      file "#{name}.rb", <<EOF
#{thing} #{names.classify}
end
EOF
    end
    directory ['spec', *dirs] do
      file "#{name}_spec.rb", <<EOF
require_relative '#{'../'*dirs.size}spec_helper'
require '#{names.join '/'}'

describe #{names.classify} do
  it 'should ...'
end
EOF
    end
  end
end
