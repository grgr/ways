require 'spec_helper'

describe 'basic functionality' do
  it 'should say hello' do
    Ways.hello.should == 'Hello'
  end
end
