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
                "View your Wizard ID Card",
                "Leave Hogwarts"
            ]
        end

        def start
            welcome_banner
            puts "What's your name? \n"
            sorting_hat
            input_name

            puts "\nHello, #{ @name }! Your journey begins with The Sorting Hat.\n"
            sleep(1)
            puts "Let's see which House you belong to...\n\n"
            sleep(2)
            puts "... #{ @house.upcase }!\n"
        end

        def level_one_commands
            get_commands
            puts "\nWhat would you like to do next?"
            puts "Enter '0' at anytime to return to this menu \n\n"
            
            # Display available commands
            @commands.each.with_index do |command, index|
                puts "#{ index + 1 }. #{ command }"
            end
            puts "\n"
    
            # Get user input
            input = gets.strip.to_i
            puts "\n"
            i = 1
                
            # Controller
            case input
            when 0
                welcome_banner
                level_one_commands
            when i 
                puts "List all Professors"
            when i + 1
                puts "List all Students"
            when i + 2
                puts "List only Students in your House"
            when i + 3
                welcome_banner
                view_spells
            when i + 4
                welcome_banner
                find_wizard
            when i + 5
                welcome_banner
                view_friends
            when i + 6
                welcome_banner
                view_enemies
            when i + 7
                welcome_banner
                view_profile
            when @commands.length
                exit_application
            else
                welcome_banner
                puts "Invalid Selection."
                level_one_commands
            end
            sleep(2)
            level_one_commands
        end

        def view_profile
            puts "   NAME: #{ self.info.name }"
            puts "  HOUSE: #{ self.info.house.name }"
            puts "FRIENDS: "
        end

        def find_wizard
            puts "\nPlease enter the full name of the Wizard you would like to find:\n\n"
            input = gets.strip
            result = Wizard.find_by_name( input )

            if input == ""
                binding.pry
                puts "\n=> Sorry, it seems #{ input } does not go to Hogwarts! Try searching a different name:"
                find_wizard
            elsif input == "0"
                level_one_commands
            elsif input == self.info.name
                puts "\n=> Last we checked, there is only ONE of you. Try searching for another wizard."
                find_wizard
            else
                puts "\n=> #{ result.name } is a #{ result.role } from House #{ result.house.name }."
                friend_wizard( result )
            end
        end

        def friend_wizard( wizard )
            puts "\nWould you like to add #{ wizard.name } as a friend? (y/n)"
            
            input = gets.strip
            if input == "y"
                puts "\n=> Great! You are now friends with #{ wizard.name }!"
                self.info.add_friend( wizard )
            elsif input == "n"
                puts "\n=> Uh oh, you have upset #{ wizard.name }! You are now enemies."
                self.info.add_enemy( wizard )
            end
        end

        def view_friends
            puts "\nHere is a list of your friends:\n"
            my_friends = self.info.friends
            if my_friends == []
                puts "\n=> You don't have any friends.\n"
            else
                my_friends.each.with_index(1){ |friend, index| puts "       #{ index }. #{ friend.name }" }
            end
        end

        def view_enemies
            puts "\nHere is a list of your enemies:\n"
            my_enemies = self.info.enemies
            if my_enemies == []
                puts "\n=> You don't have any enemies.\n"
            else
                my_enemies.each.with_index(1){ |enemy, index| puts "       #{ index }. #{ enemy.name }" }
            end
        end

        def view_spells
            puts "\nHere are all the spells you currently know:\n"
            my_spells = self.info.list_spells
            if my_spells == []
                puts "\n=> You don't know any spells.\n"
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
                puts "=> I can assure you that you are NOT invisible! You will learn that spell in your 2nd week :) \nPlease enter a valid name:"
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
            print "\e[2J\e[f"
            puts "   *      *       /\\    *     *            *  "
            puts "       *        */  \\              *          "
            puts "  *         Welcome to Hogwarts!          *   "
            puts "        *      /      \\     *         /\\      "
            puts "    *       * /        \\      /\\ *   |  |     "
            puts "     /\\      |          |    /  \\    |  |  *  "
            puts "    /  \\     | [] [] [] |   /    \\   |  |_/\\  "
            puts "   |    | /\\ |          |__|  []  |  |   [] | "
            puts " __| [] |/  \\|  []  []  |  |     _|__| []   | "
            puts "|  |    /    |          |  |    |     \\     | "
            puts "-----------------------------------------------"
        end

        def exit_application
            puts "\nWonderful having you here, #{ self.info.name }!"
            puts "Before you go, here is a summary of your experience at Hogwarts:"
            puts "      [ List User History ]\n"
            puts "We hope you enjoyed your stay!"
            exit!
        end
    end
end