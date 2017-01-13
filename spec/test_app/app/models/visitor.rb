class Visitor < ActiveRecord::Base

  def self.origin
    data = {hvv: {lat: 53.556127, long: 10.016097},
     vbb: {lat: 52.475640, long: 13.441063}}
    data[Ways.api]
  end

  def self.dest
    data = {hvv: {lat: 53.562644, long: 9.961241},
     vbb: {lat: 52.530768, long: 13.400652}}
    data[Ways.api]
  end

  def go
    Ways.from_to(Visitor.origin, Visitor.dest)
  end
end
