# coding: utf-8
require 'fileutils'
require 'rainbow'
require 'piv/preferences'
require 'piv/monkey_violence'

module Piv
  @preferences = Preferences.new

  include FileUtils

  def self.preferences
    @preferences
  end

  def edit path
    editor = ENV['PIV_EDITOR'] || 'subl'
    system "#{editor} #{path}"
  end

  def generate_project name, *flavours
    directory name do
      system 'git init' unless File.exist? '.git'
      file '.gitignore'
      file '.piv', {'flavours' => flavours}.to_yaml
      flavours.each do |flavour|
        require 'piv/'+flavour
        extend Piv.const_get flavour.classify
        initialiser = "init_#{flavour}".to_sym
        send(initialiser, name) if respond_to? initialiser
      end
    end
    edit name
  end

  def directory path
    full_path = File.join path
    mkdir_p File.join full_path
    Dir.chdir full_path do
      yield if block_given?
    end
  end

  def file path, content=''
    if File.exist? path
      puts '✔'.foreground(:green) + " #{File.join Dir.pwd, path}"
    else
      puts '✘'.foreground(:red) + " #{File.join Dir.pwd, path}"
      File.open(path, 'w') { |f| f.puts content }
    end 
    edit path
  end

  def file_content source, name
    FileUtils.cp File.dirname(source)+'/content/'+name, '.'
  end

  def license
<<EOF
Copyright (c) #{Date.today.year} #{Piv.preferences['name']}

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:
 
The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
EOF
  end
end
