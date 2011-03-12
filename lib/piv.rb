require 'fileutils'
require 'piv/directory'

module Piv
  include FileUtils

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
    name = names.pop
    directory ['lib', *names] do |dir|
      dir.file "#{name}.rb", <<EOF
#{thing} #{classify names + [name]}
end
EOF
    end
    directory ['spec', *names] do |dir|
      dir.file "#{name}_spec.rb", <<EOF
describe #{classify names + [name]}
  it 'should ...'
end
EOF
    end
  end

  def classify strings
    strings.map {|w| classify_one w}.join('::')
  end

  def classify_one string
    string.split('_').map {|w| w.capitalize}.join
  end

  def directory path
    full_path = File.join path
    mkdir_p File.join full_path
    yield Directory.new full_path if block_given?
  end
end
