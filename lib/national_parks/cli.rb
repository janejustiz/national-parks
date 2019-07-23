class NationalParks::CLI

  def call
    puts "National Parks in the United States"
    intro
    answer
    done
  end

  def intro
    puts "To see the national parks within a state/territory, please enter the state/territory's USPS abbreviation (ex: 'FL')."
    puts "To see a list of states, enter 'states'. To see a list of territories, enter 'territories'."
    puts "To exit, enter 'exit'"
  end

  def answer
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      if input == "states"
        states
        intro
      elsif input == "territories"
        territories
        intro
      else
        scrape(input)
        print_states
        intro
      end
    end
  end

  def states
    puts "US States + US Capital:"
    states = ["Alabama - AL", "Alaska - AK", "Arizona - AZ", "Arkansas - AR", "California - CA", "Colorado - CO", "Connecticut - CT", "Delware - DE", "Florida - FL", "Georgia - GA", "Hawaii - HI", "Idaho - ID", "Illanois - IL", "Indiana - IN", "Iowa - IA", "Kansas - KS", "Kentucky - KY", "Louisiana - LA", "Maine - ME", "Maryland - MD", "Massachusetts - MA", "Michigan - MI", "Minnesota - MN", "Mississippi - MS", "Missouri - MO", "Montana - MT", "Nebraska - NE", "Nevada - NV", "New Hampshire - NH", "New Jersey - NJ", "New Mexico - NM", "New York - NY", "North Carolina - NC", "North Dakota - ND", "Ohio - OH", "Oklahoma - OK", "Oregon - OR", "Pennsylvania - PA", "Rhode Island - RI", "South Carolina - SC", "South Dakota - SD", "Tennessee - TN", "Texas - TX", "Utah - UT", "Vermont - VT", "Virginia - VA", "Washington - WA", "West Virginia - WV", "Wisconsin - WI", "Wyoming - WY", "Washington, D.C. - DC"]
    states.each.with_index(1) do |s, i|
      puts "#{i}. #{s}"
    end
  end

  def territories
    territories = ["American Samoa - AS", "Guam - GU", "Puerto Rico - PR", "Virgin Islands - VI", "Northern Mariana Islands - MP"]
    puts "US Territories:"
    territories.each.with_index(1) do |t, i|
      puts "#{i}. #{t}"
    end
  end

  def done
    puts "Thank you for using my gem!"
    puts "Have a nice day!"
  end

  def scrape(input)
    NationalParks::Parks.empty
    doc = Nokogiri::HTML(open("https://www.nps.gov/state/#{input}/index.htm"))
    doc.search(".clearfix").each do |park|
      NationalParks::Parks.new(park)
    end
    NationalParks::Parks.parks.pop(2)
  end

  def print_states
    puts NationalParks::Parks.parks[0].state
    NationalParks::Parks.parks.each.with_index(1) do |park, i|
      puts "#{i}. #{park.name} - #{park.location}"
    end
  end

end
