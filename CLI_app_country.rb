module LoanEligibility
    def calculate_loan_eligibility
      self.eligible_for_loan = (gdp > 1000) && (development_status == 'developing')
    end
  end
  
  module SecurityCouncilSeat
    def calculate_un_security_council_seat
      self.un_security_council_seat = (army_strength > 10000)
    end
  end
  
  module WarOutcomePrediction
    def calculate_war_outcome
      self.war_outcome = (army_strength > 5000)
    end
  end
  
  class Country
    attr_accessor :name, :population, :gdp, :states, :army_strength, :development_status, :eligible_for_loan, :un_security_council_seat, :war_outcome
  
    def initialize(name, population, gdp, states, army_strength, development_status)
      @name = name
      @population = population
      @gdp = gdp
      @states = states
      @army_strength = army_strength
      @development_status = development_status
    end
  end
  
  class Country
    include LoanEligibility
    include SecurityCouncilSeat
    include WarOutcomePrediction
  end
  
  class CountryDataApp
    def initialize
      @countries = []
    end
  
    def add_country(country)
      @countries << country
    end
  
    def list_countries
      @countries.each { |country| puts "#{country.name}: #{country.development_status} Army_strength: #{country.army_strength} Population: #{country.population} GDP: #{country.gdp} States: #{country.states}" }
    end
  
    def run
      puts 'Country Data Application'
      puts '------------------------'
  
      loop do
        puts '1. Add a Country'
        puts '2. List Countries'
        puts '3. Check Loan Eligibility'
        puts '4. Check UN Security Council Seat Eligibility'
        puts '5. Predict War Outcome'
        puts '6. Exit'
        print 'Enter your choice: '
        choice = gets.chomp.to_i
  
        case choice
        when 1
          print 'Enter country name: '
          name = gets.chomp
          print 'Enter population: '
          population = gets.chomp.to_i
          print 'Enter GDP: '
          gdp = gets.chomp.to_f
          print 'Enter number of states: '
          states = gets.chomp.to_i
          print 'Enter army strength: '
          army_strength = gets.chomp.to_i
          print 'Enter development status (developing/developed): '
          development_status = gets.chomp.downcase
  
          country = Country.new(name, population, gdp, states, army_strength, development_status)
          add_country(country)
          puts "Added #{country.name} to the list."
        when 2
          puts 'List of Countries:'
          list_countries
        when 3
          print 'Enter country name: '
          country_name = gets.chomp
          country = @countries.find { |c| c.name == country_name }
          if country
            country.calculate_loan_eligibility
            puts "Loan Eligibility for #{country.name}: #{country.eligible_for_loan ? 'Eligible' : 'Not Eligible'}"
          else
            puts "Country not found!"
          end
        when 4
          print 'Enter country name: '
          country_name = gets.chomp
          country = @countries.find { |c| c.name == country_name }
          if country
            country.calculate_un_security_council_seat
            puts "UN Security Council Seat Eligibility for #{country.name}: #{country.un_security_council_seat ? 'Eligible' : 'Not Eligible'}"
          else
            puts "Country not found!"
          end
        when 5
          print 'Enter country name: '
          country_name = gets.chomp
          country = @countries.find { |c| c.name == country_name }
          if country
            country.calculate_war_outcome
            puts "War Outcome Prediction for #{country.name}: #{country.war_outcome ? 'Win' : 'Lose'}"
          else
            puts "Country not found!"
          end
        when 6
          puts 'Goodbye!'
          break
        else
          puts 'Invalid choice. Please try again.'
        end
      end
    end
  end
  
  app = CountryDataApp.new
  app.run
  