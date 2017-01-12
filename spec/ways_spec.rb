require 'spec_helper'

describe 'Ways' do
  it 'basic API call should be success' do
    puts "Testing #{Ways.api}-API. To test other APIs run 'cd spec/test_app && rails g ways NAME_OF_API'" 
    res = "Ways::#{Ways.api.to_s.classify}".constantize.get_results(from, to, DateTime.now, 'de', {})
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
