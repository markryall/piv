require 'yaml'
require 'piv'

class Piv::Generator
  include Piv

  def self.load
    return Piv::Generator.new unless File.exist? '.piv'
    generator = Piv::Generator.new YAML.load_file '.piv'
  end

  def initialize config={}
    @config = config
    config['flavours'].each do |flavour|
      require "piv/#{flavour}"
      extend Piv.const_get flavour.classify
    end if config['flavours']
  end

  def configured?
    !@config.empty?
  end
end
