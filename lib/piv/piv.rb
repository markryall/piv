require 'piv/ruby'

module Piv::Piv
  include Piv::Ruby

  def init_piv name
    init_ruby name
    directory 'lib/piv' do
      file "#{name}.rb", <<EOF
require 'piv'

module Piv::#{name.classify}
  include Piv

  def init_#{name} name
  end
end
EOF
    end
    directory 'spec/piv' do
      file "#{name}_spec.rb"
    end
  end
end
