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
