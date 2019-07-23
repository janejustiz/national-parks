class NationalParks::CLI

  def call
    puts "National Parks in the United States"
    intro
    input
    done
  end

  def intro
    puts "To see the national parks within a state/territory, please enter the state/territory's USPS abbreviation (ex: 'FL', not 'Florida')."
    puts "If you would like to see a list of options, enter 'list'"
    puts "To exit, enter 'exit'"
  end

  def input
    input = nil
    while input != "exit"
      input = gets.strip.downcase

      if input == "list"
        list
      else
        NationalParks::Parks.new(input)
      end
    end
  end

  def list
    puts "States: AL, AK, AZ, AR, CA, CO, CT, DE, FL, GA, HI, ID, IL, IN, IA, KS, KY, LA, ME, MD, MA, MI,MN, MS,"
    puts "MO, MT, NE, NV, NH, NJ, NM, NY, NC, ND, OH, OK, OR, PA, RI, SC, SD, TN, TX, UT, VT, VA, WA, WV, WI, WY"
    puts "Capital: DC"
    puts "Territories: AS, GU, PR, VI, MP"
    intro
  end

  def done
    puts "Thank you for using my gem!"
    puts "Have a nice day!"
  end
end
