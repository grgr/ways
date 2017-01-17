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

  def self.datetime
    DateTime.new(2017,2,3,16,5,6)
  end

  def go
    ways = Ways.from_to(Visitor.origin, Visitor.dest)
    #binding.pry
    ways
  end

  def go_further
    ways = Ways.from_to(Visitor.origin, Visitor.dest, date_time: Visitor.datetime, arrival: true, lang: 'en', trips_before: 2, trips_after: 3)
    #binding.pry
    ways
  end

end
