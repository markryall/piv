require 'fileutils'

module Piv
  require 'piv/monkey_patching'
  require 'piv/directory'

  include FileUtils

  def directory path
    full_path = File.join path
    mkdir_p File.join full_path
    yield Directory.new full_path if block_given?
  end
end
