module Commands
    module ClassMethods

    end

    module InstanceMethods
        def get_commands
            @commands = [
                "Meet my Professor",
                "Meet my Housemates",
                "Learn about the other Houses",
                "Learn a spell",
                "Look up a Wizard"
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

        def level_one_commands
            get_commands
            puts "\n    What would you like to do next? [Type 'vanish' to exit]"
            
            # Display available commands
            @commands.each.with_index do |command, index|
                puts "#{ index + 1 }. #{ command }"
            end
    
            # Collect user input
            input = gets.strip.to_i
                
            # Controller
            case input
            when 1
                puts "      List all Professors"
            when 2
                puts "      List all Students"
            when 3
                puts "      List only Students in your House"
            when 4
                puts "      List all available Spells"
            when 5
                puts "      Who would you like to find?"
                search = find_wizard
                binding.pry
            when "vanish"
                exit
            else
                puts "Invalid Selection."
                level_one_commands   # Ask for input again
            end
        end

        def find_wizard
            input = gets.strip
            result = Wizard.find_by_name( input )

            if result == nil
                puts "      Sorry, it seems #{ input } does not exist! Try another name:"
                find_wizard
            else
                puts "      #{ result.name } is a #{ result.role } from House #{ result.house.name }."
                friend_wizard( result )
            end
        end

        def friend_wizard( wizard )
            puts "      Would you like to add #{ wizard.name } as a friend? ( Y | N )"
            
            input = gets.strip
            if input == "Y"
                puts "      Great! You are now friends with #{ wizard.name }!"
                self.info.add_friend( wizard )
            elsif input == "N"
                puts "      Uh oh, you have upset #{ wizard.name }! You are now enemies."
                self.info.add_enemy( wizard )
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