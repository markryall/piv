require File.dirname(__FILE__)+'/spec_helper'
require 'piv'

describe Piv do
  include Piv

  it 'should tell those strings to classify themselves' do
    'this_is_serious'.classify.should == 'ThisIsSerious'
  end

  it 'should tell those arrays to classify themselves' do
    ['now','this_is_serious'].classify.should == 'Now::ThisIsSerious'
  end

  it 'should generate a license' do
    Date.stub_chain(:today, :year).and_return 2055
    license.should == <<EOF
Copyright (c) 2055 YOUR NAME
 
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
