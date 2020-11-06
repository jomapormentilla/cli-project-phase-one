# Command line interface
# Interacts with the user
# Connects our files together

class Cli
    attr_accessor :name

    def initialize
        puts "Welcome to Hogwarts! What's your name?"
        input_name

        puts "Hello, #{ @name }! The Sorting Hat has placed you in..."
        sleep(1)
        puts "#{ sorting_hat.upcase }!"

        binding.pry
    end
    
    def input_name
        name = gets.strip
        
        if name != ""
            @name = name
            add_student
        else
            puts "I can assure you that you are NOT invisible! Please enter a valid name:"
            input_name
        end
    end

    def sorting_hat
        House.all.collect{ |house| house.name }.sample
    end

    def add_student
        Student.new( @name, "student", sorting_hat )
    end
end