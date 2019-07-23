class NationalParks::Parks
  attr_accessor :state, :name, :url, :location, :description

  @@all = []

  def initialize(abbreviation)
    self.scrape(abbreviation)

  end

  def self.scrape(abbreviation)

  end



end
