# ways
Simple Rails wrapper-gem to get public transport routes between coordinates. 

At the moment only Berlin and Hamburg (Germany) are supported.

#### Note
You will need access to the APIs this gem is based on.
* Hamburg: HVV
* Berlin: VBB

It is best to set the access keys as environment variables. Have a look into the initializer file config/initializers/ways.rb for key naming. 


## Installation

Add the gem to your Gemfile:

```ruby
gem 'ways', git: 'git://github.com/grgr/ways.git'
```

after `bundle` create the propriate initializer file with:

```bash
rails g ways [hvv|vbb]
```

## Usage
```ruby
from = {lat: 53.556127, long: 10.016097}
to   = {lat: 53.562644, long: 9.961241}

ways = Ways.from_to(from, to)
```
from and to are the only necessary parameters. Ways expects you to search a journey starting now at from.

But there are more parameters, which can be passed as hash:

* lang: ['de' | 'en'] - default 'de'. Language.
* arrival: boolean - default false. Specified time or now is arrival time?
* date_time: DateTime - default now. Departure or arrival time.
* trips_before: int - default 0. How many trips before the given time?
* trips_after: int - default 1. How many trips after the given time incl. the trip for the given time. 

```ruby
datetime = DateTime.new(2017,2,3,16,5,6)

ways = Ways.from_to(from, to, { date_time: datetime, arrival: true, lang: 'en', trips_before: 2, trips_after: 3 })
```

## Response

For each trip (count specified via `:trips_before` and `:trips_after`) a hash containing the overall duration and a leglist are returned. Each leg in the leglist is a part of the trip and contains some info as well as origin, destination and departure- and arrival-times.

e.g.:

```ruby
[
  {
    :duration=>36,
    :leglist=> [
      {
        :info=> {:type=>"WALK", :direction=>nil}, 
        :origin=>{:name=>"Lindenstraße 40", :type=>"ADDRESS", :serviceTypes=>nil, :time=>"13:40", :date=>"18.01.2017"}, 
        :dest=>{:name=>"Lohmühlenstraße", :type=>"STATION", :serviceTypes=>"U", :time=>"13:47", :date=>"18.01.2017"}
      },
      {
        :info=>{:type=>"TRAIN", :direction=>"Ohlsdorf"}, 
        :origin=>{:name=>"Lohmühlenstraße", :type=>"STATION", :serviceTypes=>"U", :time=>"13:47", :date=>"18.01.2017"}, 
        :dest=>{:name=>"Hallerstraße", :type=>"STATION", :serviceTypes=>"U", :time=>"13:58", :date=>"18.01.2017"}
      },
      {
        :info=>{:type=>"BUS", :direction=>"Bf. Altona"}, 
        :origin=>{:name=>"U Hallerstraße", :type=>"STATION", :serviceTypes=>"BUS", :time=>"14:03", :date=>"18.01.2017"}, 
        :dest=>{:name=>"Schulterblatt", :type=>"STATION", :serviceTypes=>"BUS", :time=>"14:13", :date=>"18.01.2017"}
      },
      {
        :info=>{:type=>"WALK", :direction=>nil}, 
        :origin=>{:name=>"Schulterblatt", :type=>"STATION", :serviceTypes=>"BUS", :time=>"14:13", :date=>"18.01.2017"}, 
        :dest=>{:name=>"Schulterblatt 79", :type=>"ADDRESS", :serviceTypes=>nil, :time=>"14:16", :date=>"18.01.2017"}
      }
    ]
  }
]

```
