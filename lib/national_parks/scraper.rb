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
      a = NationalParks::States.new(state.text, value)
      scrape_parks(value, a)
    end
  end

  def scrape_parks(input, a)
    array = []
    array = Nokogiri::HTML(open("https://www.nps.gov/state/#{input}/index.htm")).search(".clearfix")
    array.pop(2)
    array.each do |park|
      b = NationalParks::Parks.new(park)
      a.parks << b
      b.state = a
    end
  end

end
