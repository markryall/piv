require 'fileutils'

class String
  def classify
    self.split('_').map(&:capitalize).join
  end
end

class Array
  def classify
    self.map(&:classify).join('::')
  end
end

module Piv
  include FileUtils

  def edit path
    editor = ENV['PIV_EDITOR'] || 'subl'
    system "#{editor} #{path}"
  end

  def generate_project flavour, name
    directory name do |dir|
      dir.file '.gitignore'
      dir.file '.piv', {'flavour' => flavour}.to_yaml
      system 'git init' unless File.exist? '.git'
      require 'piv/'+flavour
      extend Piv.const_get flavour.classify
      generate_init name if respond_to? :generate_init
    end
    edit name
  end

  def directory path
    full_path = File.join path
    mkdir_p File.join full_path
    Dir.chdir full_path do
      yield self if block_given?
    end
  end

  def file path, content=''
    File.open path, 'w' do |f|
      f.puts content
    end unless File.exist? path
    edit path
  end

  def license
<<EOF
Copyright (c) #{Date.today.year} YOUR NAME
 
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
