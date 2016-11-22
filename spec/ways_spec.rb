require 'spec_helper'

describe 'basic functionality' do
  it 'should be success' do
    res = Visitor.new.go
    expect(res).to eq(Net::HTTPSuccess)
  end

  def from
    {lat: 52.475640, long: 13.441063}
  end

  def to
    {lat: 52.530768, long: 13.400652}
  end

end
