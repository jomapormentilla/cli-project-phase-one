# Command line interface
# Interacts with the user
# Connects our files together

class Cli
    attr_accessor :name, :house

    def initialize
        puts "Welcome to Hogwarts! What's your name?"
        sorting_hat
        input_name

        puts "Hello, #{ @name }! The Sorting Hat has placed you in..."
        sleep(1)
        puts "#{ @house.upcase }!"

        binding.pry
    end
    
    def input_name
        name = gets.strip
        
        if name != ""
            @name = name
            add_student
        else
            puts "I can assure you that you are NOT invisible! You will learn that spell in your 2nd week :) \nPlease enter a valid name:"
            input_name
        end
    end

    def sorting_hat
        @house = House.all.collect{ |house| house.name }.sample
    end

    def add_student
        Student.new( @name, "Student", @house )
    end
end