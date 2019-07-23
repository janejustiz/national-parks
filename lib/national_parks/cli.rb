class NationalParks::CLI
  ENTRIES = ["al", "ak", "az", "ar", "ca", "co", "ct", "de", "fl", "ga", "hi", "id", "il", "in", "ia", "ks", "ky", "la", "me", "md", "ma", "mi", "mn", "ms", "mo", "mt", "ne", "nv", "nh", "nj", "nm", "ny", "nc", "nd", "oh", "ok", "or", "pa", "ri", "sc", "sd", "tn", "tx", "ut", "vt", "va", "wa", "wv", "wi", "wy", "dc", "as", "gu", "pr", "vi", "mp"]

  def call
    puts "National Parks in the United States"
    again
    done
  end

  def intro
    puts "To see the national parks within a state/territory, please enter the state/territory's USPS abbreviation (ex: 'FL')."
    puts "To see a list of states, enter 'states'. To see a list of territories, enter 'territories'."
    puts "To exit, enter 'exit'."
  end

  def answer
    input = gets.strip.downcase
    if input == "exit"
    elsif input == "states"
      states
      again
    elsif input == "territories"
      territories
      again
    else
      evaluation(input)
      again
    end
  end

  def again
    intro
    answer
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
    @doc = Nokogiri::HTML(open("https://www.nps.gov/state/#{input}/index.htm"))
    @doc.search(".clearfix").each do |park|
      NationalParks::Parks.new(park)
    end
    NationalParks::Parks.parks.pop(2)
  end

  def print_parks
    puts "National Parks in #{@doc.search("h1").text}"
    NationalParks::Parks.parks.each.with_index(1) do |park, i|
      puts "#{i}. #{park.name} - #{park.location}"
    end
  end

  def valid(input)
    true if ENTRIES.include?(input)
  end

  def evaluation(input)
    if valid(input) == true
      scrape(input)
      print_parks
      park_description
    else
      puts "Invalid Entry. Try again."
    end
  end

  def park_description
    puts "To learn more about a specific park, enter it's number. Otherwise, enter 'return'."
    entry = gets.strip
    if ((entry.to_i > 0) && (entry.to_i <= NationalParks::Parks.parks.size))
      puts NationalParks::Parks.parks[entry.to_i - 1].description
      park_description
    elsif entry == "return"
    else
      puts "Invalid Entry."
    end
  end

end
