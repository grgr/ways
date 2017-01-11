require 'spec_helper'

describe 'basic functionality' do
  it 'should be success' do
    res = Ways.get_results(from, to, DateTime.now, 'de', {})
    #expect(res).to eq(Net::HTTPOK)
    expect(res).to be_kind_of(Net::HTTPOK)
  end

  it 'should return trip response' do
    res = Visitor.new.go
    expect(res).to be_kind_of(Array)
    expect(res[0]).to have_key(:duration)
    expect(res[0][:duration]).to match(/PT\d+M/)
  end

  def from
    {lat: 52.475640, long: 13.441063}
  end

  def to
    {lat: 52.530768, long: 13.400652}
  end

end
