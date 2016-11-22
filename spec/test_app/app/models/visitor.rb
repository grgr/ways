class Visitor < ActiveRecord::Base

  def origin
    {lat: 52.475640, long: 13.441063}
  end

  def dest
    {lat: 52.530768, long: 13.400652}
  end

end
