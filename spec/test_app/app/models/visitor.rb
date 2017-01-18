class Visitor < ActiveRecord::Base

  def self.origin
    data = {hvv: {lat: 53.556127, long: 10.016097},
    #data = {hvv: {lat: 53.714778, long: 10.078419},
     vbb: {lat: 52.475640, long: 13.441063}}
    data[Ways.api]
  end

  def self.dest
    data = {hvv: {lat: 53.562644, long: 9.961241},
    #data = {hvv: {lat: 53.454874, long: 10.283733},
     vbb: {lat: 52.530768, long: 13.400652}}
    data[Ways.api]
  end

  def self.datetime
    DateTime.now + 3.days
  end

  def go
    ways = Ways.from_to(Visitor.origin, Visitor.dest)
    binding.pry
    ways
  end

  def go_further
    ways = Ways.from_to(Visitor.origin, Visitor.dest, date_time: Visitor.datetime, arrival: true, lang: 'en', trips_before: 2, trips_after: 3)
    #binding.pry
    ways
  end

end
