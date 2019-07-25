class NationalParks::Scraper

  def initialize
    scrape_states
  end

  def scrape_states
    array = []
    array = Nokogiri::HTML(open("https://www.nps.gov/findapark/index.htm")).css("#state option")
    array.shift
    array.each do |state|
      value = state.attr('value')
      NationalParks::States.new(state.text.strip, value.strip)
    end
  end

  def self.scrape_parks(input, a)
    array = []
    array = Nokogiri::HTML(open("https://www.nps.gov/state/#{input}/index.htm")).search(".clearfix")
    array.pop
    array.pop
    array.each do |park|
      b = NationalParks::Parks.new(park)
      a.parks << b
      b.state = a
    end
  end

end
