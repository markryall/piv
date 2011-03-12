require 'fileutils'

module Piv
  require 'piv/monkey_patching'
  require 'piv/directory'

  include FileUtils

  def generate_project flavour, name
    directory name do |dir|
      dir.file '.gitignore'
      dir.file '.piv', {'flavour' => flavour}.to_yaml
      system 'git init' unless File.exist? '.git'
      require 'piv/'+flavour
      extend Piv.const_get flavour.classify
      generate_init if respond_to? :generate_init
    end
  end

  def directory path
    full_path = File.join path
    mkdir_p File.join full_path
    Dir.chdir full_path do
      yield Directory.new full_path if block_given?
    end
  end
end
