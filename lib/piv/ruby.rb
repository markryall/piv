require 'piv'

module Piv::Ruby
  include Piv

  def generate_init *ignored
    directory 'lib'
    directory 'spec'
  end

  def generate_declass *names
    degenerate_ruby 'class', names
  end

  def generate_demodule *names
    degenerate_ruby 'module', names
  end

  def generate_class *names
    generate_ruby 'class', names
  end

  def generate_module *names
    generate_ruby 'module', names
  end
private
  def degenerate_ruby thing, names
    rm "lib/#{names.join '/'}.rb"
    rm "spec/#{names.join '/'}_spec.rb"
  end

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
