$: << File.dirname(__FILE__)+'/../lib'

require 'tempfile'
require 'fileutils'
require 'piv/generator'

module FileSystem
  attr_reader :files, :directories

  def directory name
    @stack.push name
    @directories << @stack.join('/')
    yield if block_given?
    @stack.pop
  end

  def file name, content=nil
    path = [*@stack, name].join('/')
    @files << (content ? [path, content] : path)
  end

  def init_filesystem
    @stack ||= []
    @directories ||= []
    @files ||= []
  end
end

def in_temp_directory
  tempfile = Tempfile.new('')
  tempdir = tempfile.path
  tempfile.close!
  begin
    FileUtils.mkdir_p tempdir
    Dir.chdir(tempdir) do
      yield
    end
  ensure
    FileUtils.rm_rf tempdir
  end
end

def write_file content, *paths
  path = File.join(*paths)
  FileUtils.mkdir_p File.dirname(path)
  File.open(path, 'w') {|file| file.puts content}
end