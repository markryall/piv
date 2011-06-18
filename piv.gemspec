
Gem::Specification.new do |spec|
  spec.name = 'piv'
  spec.version = '0.0.1'
  spec.summary = 'the ultimate command line productivity tool'
  spec.description = <<-EOF
a simple and extensible command line file generator
EOF
  spec.authors << 'Mark Ryall'
  spec.email = 'mark@ryall.name'
  spec.homepage = 'https://github.com/markryall/piv'
  spec.files = Dir['lib/**/*'] + Dir['spec/**/*'] + Dir['bin/*'] + ['README.rdoc', 'MIT-LICENSE', 'HISTORY.rdoc', 'Rakefile', '.gemtest']
  spec.executables << 'piv'

  spec.add_development_dependency 'rake', '~>0.8'
  spec.add_development_dependency 'rspec', '~>2'
end
