require File.dirname(__FILE__)+'/../spec_helper'
require 'piv/generator'

describe Piv::Generator do
  describe '#load' do
    it 'should return unconfigured generator when configuration file does not exist' do
      generator = stub 'generator'
      File.should_receive(:exist?).with('.piv').and_return false
      Piv::Generator.should_receive(:new).and_return generator
      Piv::Generator.load.should == generator
    end

    it 'should return configured generator when configuration file does exist' do
      generator = stub 'generator'
      configuration = stub 'configuration'
      File.should_receive(:exist?).with('.piv').and_return true
      YAML.should_receive(:load_file).with('.piv').and_return configuration
      Piv::Generator.should_receive(:new).and_return generator
      Piv::Generator.load.should == generator
    end
  end
end
