require File.dirname(__FILE__)+'/../spec_helper'
require 'piv/piv'

describe Piv::Piv do
  include Piv::Piv

  describe '#init_piv' do
    it 'should generate a piv directory' do
      should_receive(:init_ruby).with 'project_name'
      should_receive(:directory).with 'lib/piv'
      should_receive(:directory).with 'spec/piv'
      init_piv 'project_name'
    end
  end
end
