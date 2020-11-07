module Commands
    module ClassMethods

    end

    module InstanceMethods
        def get_commands
            @commands = [
                "List all Professors",
                "List all Students",
                "List only Students in your House",
                "List all available Spells",
                "Look up a Wizard",
                "View a list of your Friends",
                "View a list of your Enemies",
                "Leave Hogwarts"
            ]
        end

        def start
            welcome_banner
            puts "      What's your name?"
            sorting_hat
            input_name

            puts "      Hello, #{ @name }! Your journey begins with The Sorting Hat."
            sleep(2)
            puts "      Let's see which House you belong to..."
            puts ""
            sleep(2)
            puts "      ... #{ @house.upcase }!\n"
        end

        def level_one_commands
            get_commands
            puts "\n      What would you like to do next?"
            puts "\n"
            
            # Display available commands
            @commands.each.with_index do |command, index|
                puts "      #{ index + 1 }. #{ command }"
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
                puts "      Here are all the spells you currently know:"
                view_spells
            when 5
                puts "      Who would you like to find?"
                search = find_wizard
            when 6
                puts "      Here is a list of your friends:"
                view_friends
            when 7
                puts "      Your enemies are:"
            when 8
                puts "      No problem, #{ self.info.name }!"
                puts "      Before you go, here is a summary of your experience at Hogwarts:"
                puts "          [ List User History ]\n"
                puts "      See you again soon!"
                exit!
            else
                puts "Invalid Selection."
                level_one_commands   # Ask for input again
            end
            sleep(2)
            level_one_commands
        end

        def find_wizard
            input = gets.strip
            result = Wizard.find_by_name( input )

            if result == nil
                puts "      => Sorry, it seems #{ input } does not go to Hogwarts! Try searching a different name:"
                find_wizard
            else
                puts "      => #{ result.name } is a #{ result.role } from House #{ result.house.name }."
                friend_wizard( result )
            end
        end

        def friend_wizard( wizard )
            puts "      Would you like to add #{ wizard.name } as a friend? ( Y | N )"
            
            input = gets.strip
            if input == "Y"
                puts "      => Great! You are now friends with #{ wizard.name }!"
                self.info.add_friend( wizard )
            elsif input == "N"
                puts "      => Uh oh, you have upset #{ wizard.name }! You are now enemies."
                self.info.add_enemy( wizard )
            end
        end

        def view_friends
            my_friends = self.info.friends
            if my_friends == []
                puts "      => You don't have any friends."
            else
                my_friends.each.with_index(1){ |friend, index| puts "       #{ index }. #{ friend.name }" }
            end
        end

        def view_spells
            my_spells = self.info.list_spells
            if my_spells == []
                puts "      => You don't know any spells."
            else
                my_spells.each.with_index(1){ |spell, index| puts "#{ index }. #{ spell }" }
            end
        end
        
        def input_name
            name = gets.strip
            
            if name != ""
                @name = name
                add_student
            else
                puts "      => I can assure you that you are NOT invisible! You will learn that spell in your 2nd week :) \nPlease enter a valid name:"
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
            puts "    *             *     *       "
            puts " *        *                  *  "
            puts "      Welcome to Hogwarts!      "
            puts "  *                   *         "
            puts "      *        *           *    "
            puts "                                "
        end
    end
end