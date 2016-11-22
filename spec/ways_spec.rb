require 'spec_helper'

describe 'basic functionality' do
  it 'should get a route' do
    Ways.from_to(from, to)
  end

  def from
    {lat: 52.475640, long: 13.441063}
  end

  def to
    {lat: 52.530768, long: 13.400652}
  end

end
