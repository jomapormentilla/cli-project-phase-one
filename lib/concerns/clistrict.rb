module Clistrict
    module ClassMethods
    end

    module InstanceMethods
        def start
            welcome_banner
            puts "What's your name? \n"
            sorting_hat
            input_name

            puts "\nYou're a wizard, #{ self.info.name }! Your journey begins with The Sorting Hat.\n"
            sleep(1)
            puts "Let's see which House you belong to...\n\n"
            # sleep(3)
            puts "... #{ self.info.house.name }!\n"
            sleep(1)

            get_commands
        end

        def add_to_history( string )
            @history << string
        end

        def input_name
            name = gets.strip
            
            if name != ""
                @name = name
                self.info = Student.new( @name, "Student", @house )
            else
                puts "=> I assure you that you are NOT invisible! You will learn that spell soon. \nPlease enter a valid name:"
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
            puts "Before you go, here is a transcript of your experience at Hogwarts:\n\n"
            @history.each do |event|
                puts "- #{ event }"
            end
            puts "\n=> See you again soon, #{ self.info.name }!\n\n"
            exit!
        end
    end
end