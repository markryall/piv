require File.dirname(__FILE__)+'/../spec_helper'
require 'piv/piv'

describe Piv::Piv do
  include Piv::Piv
  include FileSystem

  before { init_filesystem }

  describe '#init_piv' do
    it 'should generate a piv directory' do
      stub!(:license).and_return 'a license'
      init_piv 'project_name'
      directories.should == [
        'lib/project_name',
        'spec',
        'spec/project_name',
        'lib/piv',
        'spec/piv'
      ]
      files.should == [
        ['.rvmrc', "rvm use 1.9.2@project_name --create\n"],
        ['spec/spec_helper.rb', "$: << File.expand_path('../../lib', __FILE__)\n\nrequire 'rspec'\n"],
        '.gemtest',
        'Rakefile',
        ['Gemfile', "source 'http://rubygems.org'\ngem 'rspec'\n"],
        ['README.rdoc', "= project_name\n\na THING\n\n== rationale\n\n* because THINGS are just better this way\n"],
        'HISTORY.rdoc',
        ['MIT-LICENSE', 'a license'],
        ['lib/piv/project_name.rb', <<EOF],
require 'piv'

module Piv::ProjectName
  include Piv

  def init_project_name name
  end
end
EOF
        'spec/piv/project_name_spec.rb'
      ]
    end
  end
end
