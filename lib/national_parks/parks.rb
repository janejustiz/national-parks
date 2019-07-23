class NationalParks::Parks
  attr_accessor :name, :url, :location, :description

  @@parks = []

  def initialize(park)
    self.name = park.search("h3").text.strip
    self.url = "https://www.nps.gov#{park.search("a").attr("href").text.strip}index.htm"
    self.location = park.search("h4").text.strip
    self.description = park.search("p").text.strip
    @@parks << self
  end

  def self.parks
    @@parks
  end

  def self.empty
    self.parks.clear
  end

end
