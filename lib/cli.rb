# Command line interface
# Interacts with the user
# Connects our files together

class Cli
    def initialize
        puts "Welcome! What's your name?"
        input = gets.strip
        
        puts "Hello, #{ input }! The Sorting Hat has placed you in..."
        sleep(1)
        puts "#{ sorting_hat }!"
        binding.pry
    end

    def sorting_hat
        House.all.collect{ |house| house.name }.sample.upcase
    end
end