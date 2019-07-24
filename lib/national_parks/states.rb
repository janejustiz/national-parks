class NationalParks::States
  @states = []

  def initialize
    Nokogiri::HTML(open("https://www.nps.gov/findapark/index.htm")).css("#state option").each do |park|
      @states << park.attr('value')
    end
    @states.shift
  end

  def states
    @states
  end

end
