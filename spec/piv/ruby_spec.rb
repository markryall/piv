require File.dirname(__FILE__)+'/../spec_helper'
require 'piv/ruby'

describe Piv::Ruby do
  include Piv::Ruby

  before do
    @stack = []
    @directories = []
    @files = []
  end

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

  describe '#init_ruby' do
    it 'should create files and directories' do
      stub!(:license).and_return 'a license'
      init_ruby 'project_name'
      @directories.should == [
        'lib/project_name',
        'spec',
        'spec/project_name'
      ]
      @files.should == [
        'spec/spec_helper.rb',
        '.gemtest',
        'Rakefile',
        ['Gemfile', <<EOF],
source 'http://rubygems.org'
gem 'rspec'
EOF
        ['README.rdoc', <<EOF],
= project_name

a THING

== rationale

* because THINGS are just better this way
EOF
        'HISTORY.rdoc',
        ['MIT-LICENSE', 'a license']
      ]
    end
  end
end
