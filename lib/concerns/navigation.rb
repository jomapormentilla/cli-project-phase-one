module Navigation
    module ClassMethods
    end

    module InstanceMethods
        def get_commands
            @commands = [
                {
                    title: "Information about all Houses",
                    cmd: 'house', 
                    method: 'list_houses'   
                },
                {
                    title: "List all Professors",
                    cmd: 'professor',
                    method: 'professor_options'
                },
                {
                    title: "List all Students",
                    cmd: 'student',
                    method: 'student_options'
                },
                {
                    title: "List all available Spells",
                    cmd: 'spells', 
                    method: 'spell_options'   
                },
                {
                    title: "View your Wizard ID Card",
                    cmd: 'profile', 
                    method: 'profile_options'  
                },
                {
                    title: "Search",
                    cmd: 'search', 
                    method: 'search_options'  
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
            puts "\nWhat would you like to do next, #{ self.info.name }?\n\n"
            
            @commands.each do |command|
                buffer = 15 - command[:cmd].split("").length
                arr = Array.new(buffer, " ").join("")
                
                puts "      `#{ command[:cmd] }` #{ arr } - #{ command[:title] }"
            end
            puts "\n"
            input = gets.strip
            find_cmd = @commands.detect{ |command| command[:cmd] == input }

            welcome_banner
            if find_cmd != nil
                puts "=> #{ input }\n\n"
                self.send(find_cmd[:method])
            else
                puts "=> Invalid Selection.\n"
            end

            sleep(1)
            main_menu
        end

        def professor_options
            options = [
                "Main Menu",
                "List Alphabetically",
                "List by House",
                "List by Role",
                "Create New"
            ]

            options.each.with_index do |option, index|
                puts "#{ index }. #{ option }"
            end

            puts "\n"
            input = gets.strip
            case input
            when "0"
                main_menu
            when "1"
                list_professors
            when "2"
                puts "Implement This."
            when "3"
                puts "Implement This."
            when "4"
                puts "Implement This."
            else
                puts "=> Invalid Selection\n\n"
                professor_options
            end
        end

        def student_options
            options = [
                "Main Menu",
                "List All",
                "Sort By Last Name",
                "Create New"
            ]

            options.each.with_index do |option, index|
                puts "#{ index }. #{ option }"
            end

            puts "\n"
            input = gets.strip
            case input
            when "0"
                main_menu
            when "1"
                list_studets
            when "2"
                puts "Implement This."
            when "3"
                puts "Implement This."
            else
                puts "=> Invalid Selection\n\n"
                student_options
            end
        end

        def spell_options
            options = [
                "Main Menu",
                "List Alphabetically",
                "Create a Spell",
                "Teach a Spell",
                "Most Popular"
            ]

            options.each.with_index do |option, index|
                puts "#{ index }. #{ option }"
            end

            puts "\n"
            input = gets.strip
            case input
            when "0"
                main_menu
            when "1"
                learn_spell
            when "2"
                create_spell
            when "3"
                teach_spell
            when "4"
                puts "Implement This."
            else
                puts "=> Invalid Selection\n\n"
                professor_options
            end
        end

        def profile_options
            options = [
                "Main Menu",
                "Your Profile",
                "Your Spells",
                "Friends",
                "Enemies",
            ]

            options.each.with_index do |option, index|
                puts "#{ index }. #{ option }"
            end

            puts "\n"
            input = gets.strip
            case input
            when "0"
                main_menu
            when "1"
                view_profile
            when "2"
                view_spells
            when "3"
                view_friends
            when "4"
                view_eemies
            else
                puts "=> Invalid Selection\n\n"
                professor_options
            end
        end

        def search_options
            options = [
                "Main Menu",
                "House",
                "Wizard",
                "Spells"
            ]

            options.each.with_index do |option, index|
                puts "#{ index }. #{ option }"
            end

            puts "\n"
            input = gets.strip
            case input
            when "0"
                main_menu
            when "1"
                list_professors
            when "2"
                find_wizard
            when "3"
                puts "Implement This."
            else
                puts "=> Invalid Selection\n\n"
                professor_options
            end
        end
    end
end