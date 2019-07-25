class NationalParks::CLI

  @@scraped = []

  def call
    NationalParks::Scraper.new
    @states = NationalParks::States.states
    @parks = NationalParks::Parks.parks
    puts "National Parks in the United States"
    again
    done
  end

  def intro
    puts "To see the national parks within a state/territory, please enter a state/territory (ex: 'Florida')."
    puts "To see a list of states/territories, enter 'list'."
    puts "To exit, enter 'exit'."
  end

  def answer
    @input = gets.strip
    @input = @input.split.map(&:capitalize).join(' ')
    case @input
    when "Exit"
    when "List"
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
    @states.each.with_index(1) do |s, i|
      puts "#{i}. #{s.name}"
    end
  end

  def done
    puts "Bye! Have a nice day!"
  end

  def evaluation
    if valid == true
      find
      print_parks
      park_description
    else
      puts "Invalid Entry. Try again."
    end
  end

  def valid
    @object = ""
    if @states.detect{|a| a.name == @input} != nil
      @object = @states.detect{|a| a.name == @input}
    true
    end
  end

  def find
    if @@scraped.detect{|a| a == @object} == nil
      NationalParks::Scraper.scrape_parks(@object.value, @object)
      @@scraped << @object
    end
  end

  def print_parks
    puts "National Parks in #{@input}"
    @object.parks.each.with_index(1) do |park, i|
      puts "#{i}. #{park.name} - #{park.location}"
    end
  end

  def park_description
    puts "To learn more about a specific park, enter it's number. Otherwise, enter 'exit'."
    entry = gets.strip
    entry.capitalize!
    if ((entry.to_i > 0) && (entry.to_i <= @object.parks.size))
      puts "URL: #{@object.parks[entry.to_i - 1].url}"
      puts "Description: #{@object.parks[entry.to_i - 1].description}"
      park_description
    elsif entry == "Exit"
    else
      puts "Invalid Entry."
    end
  end

end
