$: << File.dirname(__FILE__)+'/../lib'

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