require File.dirname(__FILE__)+'/../spec_helper'
require 'piv/ruby'

describe Piv::Ruby do
  include Piv::Ruby
  include FileSystem

  before { init_filesystem }

  describe '#init_ruby' do
    it 'should create files and directories' do
      stub!(:license).and_return 'a license'
      init_ruby 'project_name'
      directories.should == [
        'lib/project_name',
        'spec',
        'spec/project_name'
      ]
      files.should == [
        ['.rvmrc', "rvm use 1.9.2@project_name --create\n"],
        ['spec/spec_helper.rb', "$: << File.expand_path('../../lib', __FILE__)\n\nrequire 'rspec'\n"],
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

  it 'should create ruby files'
  it 'should destroy ruby class files'
  it 'should destroy ruby module files'
  it 'should generate gems'
end
