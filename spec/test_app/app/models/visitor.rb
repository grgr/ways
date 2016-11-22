class Visitor < ActiveRecord::Base

  def self.origin
    {lat: 52.475640, long: 13.441063}
  end

  def self.dest
    {lat: 52.530768, long: 13.400652}
  end

  def go
    Ways.from_to(Visitor.origin, Visitor.dest)
  end
end
