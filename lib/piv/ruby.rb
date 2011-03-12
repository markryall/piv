require 'piv'

module Piv::Ruby
  include Piv

  def generate_project
    touch '.gitignore'
    directory 'lib'
    directory 'spec'

    system "git init" unless File.exist? '.git'
  end

  def generate_class names
    generate_ruby 'class', names
  end

  def generate_module names
    generate_ruby 'module', names
  end
private
  def generate_ruby thing, names
    name, dirs = names.last, names.slice(0...-1)
    directory ['lib', *dirs] do |dir|
      dir.file "#{name}.rb", <<EOF
#{thing} #{names.classify}
end
EOF
    end
    directory ['spec', *dirs] do |dir|
      dir.file "#{name}_spec.rb", <<EOF
describe #{names.classify}
  it 'should ...'
end
EOF
    end
  end
end
