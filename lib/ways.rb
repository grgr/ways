module Ways
  def self.hello
    "Hello"
  end

  def self.setup
    yield self
  end 

  mattr_accessor :api
  mattr_accessor :api_access_id

end
