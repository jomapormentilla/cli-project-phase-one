module Navigation
    module ClassMethods
    end

    module InstanceMethods
        def get_commands
            @commands = [
                {
                    title: "Information about all Houses",
                    cmd: 'houses', 
                    method: 'list_houses'   
                },
                {
                    title: "Professors >>",
                    cmd: 'professors',
                    method: 'professor_options'
                },
                {
                    title: "Students >>",
                    cmd: 'students',
                    method: 'student_options'
                },
                {
                    title: "Spells >>",
                    cmd: 'spells', 
                    method: 'spell_options'   
                },
                {
                    title: "Profile >>",
                    cmd: 'profile', 
                    method: 'profile_options'  
                },
                {
                    title: "Search >>",
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
                puts "=> Invalid Selection: '#{ input }'\n"
            end

            # sleep(1)
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
                list_students
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
                "Learn a Spell",
                "Create a Spell",
                "Teach a Spell",
                "Spells You Know",
                "Search for a Spell",
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
                view_spells
            when "5"
                find_spell
            when "6"
                puts "Implement This."
            else
                puts "=> Invalid Selection\n\n"
                spell_options
            end
        end

        def profile_options
            options = [
                "Main Menu",
                "Profile",
                "Spells",
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
                view_profile( self.info )
            when "2"
                view_spells
            when "3"
                view_friends
            when "4"
                view_enemies
            else
                puts "=> Invalid Selection\n\n"
                profile_options
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
                find_spell
            else
                puts "=> Invalid Selection\n\n"
                search_options
            end
        end
    end
end