class NationalParks::States
  attr_accessor :name, :value, :parks

  @@states = []

  def initialize(name, value)
    self.name = name
    self.value = value
    @parks = []
    @@states << self
  end

  def self.states
    @@states
  end

  def parks
    @parks
  end

end
