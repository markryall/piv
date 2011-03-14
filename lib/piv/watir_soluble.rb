require 'piv'

module Piv::WatirSoluble
  include Piv

  def generate_init name
  	directory 'conf'
    directory 'features' do
    	directory 'support' do
    		file 'env.rb', <<EOF
require 'rspec/expectations'
EOF
    	end
    end
    generate_app name
    directory 'spec'
    file 'cucumber.yml', <<EOF
default: -r features --tags ~@wip --color --format pretty
wip: -r features --tags @wip --color --format pretty
production: -r features --tags @wip --tags @production_safe --color --format pretty
EOF
    file 'Gemfile', <<EOF
source 'http://rubygems.org'
gem 'cucumber'
gem 'watir-webdriver'
gem 'nokogiri'
gem 'rspec-expectations'
EOF
  end

  def generate_feature *names
  	name, dirs = names.last, names.slice(0...-1)
    directory ['features', *dirs] do
    	file "#{name}.feature", <<EOF
Feature:
  As a ROLE
  I want to ACTION
  So BENEFIT

Scenario: The ROLE successfully DOES SOMETHING
  Given I DID SOMETHING
  When I DO SOMETHING
  Then I SEE SOMETHING
EOF
  	end
  end

  def generate_app name
    directory 'features' do
      directory name
      directory 'step_definitions' do
        file "#{name}_steps.rb"         
      end
    end
    directory 'lib' do
      file "#{name}.rb"
      directory name do
        directory 'model'
      end
    end
  end  
end
