module Ways
  def self.hello
    "Hello"
  end

  def self.setup
    yield self
  end 

  mattr_accessor :api

end
