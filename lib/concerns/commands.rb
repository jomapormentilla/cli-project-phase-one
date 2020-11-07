module Commands
    module ClassMethods

    end

    module InstanceMethods
        def get_commands
            @commands = [
                "Meet my Professor",
                "Meet my Housemates",
                "Learn about the other Houses",
                "Learn a spell"
            ]
        end

        def start
            welcome_banner
            puts "      What's your name?"
            sorting_hat
            input_name

            puts "      Hello, #{ @name }! Your journey begins with The Sorting Hat."
            sleep(1)
            puts "      Let's see which House you belong to..."
            puts ""
            sleep(1)
            puts "      #{ @house.upcase }!\n"
        end

        def stage_one
            get_commands
            puts "\n    What would you like to do next?"
            
            # Display available commands
            @commands.each.with_index do |command, index|
                puts "#{ index + 1 }. #{ command }"
            end
    
            # Collect user input
            input = gets.strip.to_i
                
            # Controller
            case input
            when 1
                puts "Your professor is..."
            when 2
                puts "Your housemates are..."
            when 3
                puts "The other houses are..."
            when 4
                puts "Which spell would you like to learn"
            else
                puts "Invalid Selection."
                stage_one   # Ask for input again
            end
        end
        
        def input_name
            name = gets.strip
            
            if name != ""
                @name = name
                add_student
            else
                puts "      I can assure you that you are NOT invisible! You will learn that spell in your 2nd week :) \nPlease enter a valid name:"
                input_name
            end
        end
    
        def sorting_hat
            @house = House.all.collect{ |house| house.name }.sample
        end
    
        def add_student
            self.info = Student.new( @name, "Student", @house )
        end
    
        def welcome_banner
            puts "    *     *       *     *     "
            puts " *            *              *"
            puts "    Welcome to Hogwarts!      "
            puts "           *          *       "
            puts "      *        *           *  "
            puts "                              "
        end
    end
end