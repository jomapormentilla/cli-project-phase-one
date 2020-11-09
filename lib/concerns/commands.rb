module Commands
    module ClassMethods

    end

    module InstanceMethods
        def start
            welcome_banner
            puts "What's your name? \n"
            sorting_hat
            input_name

            puts "\nHello, #{ self.info.name }! Your journey begins with The Sorting Hat.\n"
            sleep(1)
            puts "Let's see which House you belong to...\n\n"
            # sleep(3)
            puts "... #{ self.info.house.name }!\n"
            sleep(1)

            get_commands
        end
        
        def get_commands
            @commands = [
                {
                    title: "List all Professors",
                    cmd: 'professors',
                    method: 'list_professors'
                },
                {
                    title: "List all Students",
                    cmd: 'students',
                    method: 'list_students'
                },
                {
                    title: "List all available Spells",
                    cmd: 'spells', 
                    method: 'view_spells'   
                },
                {
                    title: "Learn a new spell",
                    cmd: 'learn', 
                    method: 'learn_spell'   
                },
                {
                    title: "List only Students in your House",
                    cmd: 'housemates', 
                    method: 'list_students'  
                },
                {
                    title: "Look up a Wizard",
                    cmd: 'find', 
                    method: 'find_wizard'  
                },
                {
                    title: "View a list of your Friends",
                    cmd: 'friends', 
                    method: 'view_friends'  
                },
                {
                    title: "View a list of your Enemies",
                    cmd: 'enemies', 
                    method: 'view_enemies'  
                },
                {
                    title: "View your Wizard ID Card",
                    cmd: 'profile', 
                    method: 'view_profile'  
                },
                {
                    title: "Binding Pry",
                    cmd: 'pry',
                    method: 'use_pry'
                },
                {
                    title: "Leave Hogwarts",
                    cmd: 'quit',
                    method: 'exit_application'  
                }
            ]
        end

        def main_menu
            puts "\n"
            puts "What would you like to do next, #{ self.info.name }?\n\n"
            
            # Display available commands
            @commands.each do |command|
                # Aligns the Command Titles in the CLI
                buffer = 15 - command[:cmd].split("").length
                arr = Array.new(buffer, " ").join("")
                
                puts "`#{ command[:cmd] }` #{ arr } - #{ command[:title] }"
            end
            puts "\n"
    
            # Get user input
            input = gets.strip
            
            # Does this command exist
            find_cmd = @commands.detect{ |command| command[:cmd] == input }

            welcome_banner
            if find_cmd != nil
                puts "=> #{ input }\n\n"            # Show the user's input
                self.send(find_cmd[:method])        # Run associated method
            else
                puts "=> Invalid Selection.\n"
            end

            # Return to main menu
            sleep(1)
            main_menu
        end

        def list_professors
            puts "Hogwarts Professors:\n"
            Professor.all.collect.with_index(1){ |wizard, index| puts "     #{ index }. #{ wizard.name }" }
        end

        def list_students
            puts "Hogwarts Students:\n"
            Student.all.collect.with_index(1){ |wizard, index| puts "     #{ index }. #{ wizard.name }" }
        end

        def view_profile
            puts "   NAME: #{ self.info.name }"
            puts "  HOUSE: #{ self.info.house.name }"
            puts "FRIENDS: "
            puts "          #{ view_friends }"
        end

        def find_wizard
            puts "Please enter the First, Last, or Full Name of the Wizard you would like to find: \n\n"
            input = gets.strip
            result = Wizard.find_by_first_or_last_name( input )

            if input == "" || result == nil
                puts "\n=> Sorry, it seems #{ input } does not go to Hogwarts! Try searching a different name:"
                find_wizard
            elsif input == "0"
                main_menu
            elsif input == self.info.name
                puts "\n=> Last we checked, there is only ONE of you. Try searching for another wizard."
                find_wizard
            else
                puts "\n=> #{ result.name } is a #{ result.role } from House #{ result.house.name }."
                friend_wizard( result )
            end
        end

        def friend_wizard( wizard )
            puts "Would you like to add #{ wizard.name } as a friend? (y/n)"
            
            input = gets.strip
            if input == "y"
                puts "\n=> Great! You are now friends with #{ wizard.name }!"
                self.info.add_friend( wizard )
                @history << "Became friends with #{ wizard.name }."
            elsif input == "n"
                puts "\n=> Uh oh, you have upset #{ wizard.name }! You are now enemies."
                self.info.add_enemy( wizard )
                @history << "Became enemies with #{ wizard.name }."
            end
        end

        def view_friends
            my_friends = self.info.friends
            if my_friends == []
                puts "\n=> You don't have any friends.\n"
            else
                my_friends.each.with_index(1){ |friend, index| puts "       #{ index }. #{ friend.name }" }
            end
        end

        def view_enemies
            puts "#{ self.info.name }'s enemies:\n"
            my_enemies = self.info.enemies
            if my_enemies == []
                puts "\n=> You don't have any enemies.\n"
            else
                my_enemies.each.with_index(1){ |enemy, index| puts "       #{ index }. #{ enemy.name }" }
            end
        end

        def view_spells
            puts "Here are all the spells you currently know:\n\n"
            
            if self.info.spells == []
                puts "\n=> You don't know any spells.\n"
            else
                self.info.spells.each{ |spell| 
                    puts "  Name: #{ spell.name }" 
                    puts "  Type: #{ spell.type }"
                    puts "Effect: #{ spell.effect.split.map(&:capitalize).join(" ") } \n\n"
                }
            end
        end

        def learn_spell
            all_spells = Spell.all.collect.with_index(1){ |spell, index| puts "#{ index }. #{ spell.name }" }
            
            puts "Which spell would you like to learn?"
            input = gets.strip.to_i
            if input.between?(0, all_spells.length)
                new_spell = Spell.all[input-1]
                self.info.learn_spell( new_spell )
                puts "\n=> Congratulations! You have learned #{ new_spell.name }!"
                @history << "Learned #{ new_spell.name }!"
            else
                welcome_banner
                puts "=> Invalid Selection"
                learn_spell
            end
        end
        
        def input_name
            name = gets.strip
            
            if name != ""
                @name = name
                self.info = Student.new( @name, "Student", @house )
            else
                puts "=> I can assure you that you are NOT invisible! You will learn that spell in your 2nd week :) \nPlease enter a valid name:"
                input_name
            end
        end
    
        def sorting_hat
            @house = House.all.collect{ |house| house.name }.sample
        end

        def use_pry
            binding.pry
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
            puts " "
        end

        def exit_application
            puts "Before you go, here is a summary of your experience at Hogwarts:\n\n"
            @history.each do |event|
                puts "- #{ event }"
            end
            puts "\n=> See you again soon, #{ self.info.name }!\n\n"
            exit!
        end
    end
end