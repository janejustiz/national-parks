class NationalParks::CLI

  def call
    NationalParks::Scraper.new
    @states = NationalParks::States.states
    @parks = NationalParks::Parks.parks
    puts "National Parks in the United States"
    again
    done
  end

  def intro
    puts "To see the national parks within a state/territory, please enter a state/territory."
    puts "To see a list of states/territories, enter 'list'."
    puts "To exit, enter 'exit'."
  end

  def answer
    @input = gets.strip.downcase
    if @input == "exit"
    elsif @input == "list"
      list
      again
    else
      evaluation
      again
    end
  end

  def again
    intro
    answer
  end

  def list
    puts "US States, Capital, and Territories:"
    @states.name.each.with_index(1) do |s, i|
      puts "#{i}. #{s}"
    end
  end

  def done
    puts "Thank you for using my gem!"
    puts "Have a nice day!"
  end

  def evaluation
    if valid == true
      print_parks
      park_description
    else
      puts "Invalid Entry. Try again."
    end
  end

  def valid
    true if @states.value.include?(@input)
  end

  def print_parks
    puts "National Parks in #{@input.name}"
    @input.parks.each.with_index(1) do |park, i|
      puts "#{i}. #{park.name} - #{park.location}"
    end
  end

  def park_description
    puts "To learn more about a specific park, enter it's number. Otherwise, enter 'exit'."
    entry = gets.strip
    if ((entry.to_i > 0) && (entry.to_i <= @input.parks.size))
      puts @input.parks[entry.to_i - 1].url
      puts @input.parks[entry.to_i - 1].description
      park_description
    elsif entry == "exit"
    else
      puts "Invalid Entry."
    end
  end

end
